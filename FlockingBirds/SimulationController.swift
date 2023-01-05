//
//  SimulationController.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/7/22.
//

import Foundation
import SwiftUI

enum Status {
    case paused, running
}

class SimulationController: ObservableObject {

    let birdImage = Image("birdnoheading")
    let predatorImage = Image("predator")
    let trailImage = Image("trail")
    var birds: [Bird] = []
    var predators: [Bird] = []
    var birdPath = Set<Trail>();
    var simStatus = Status.paused
    let behaviors = Behaviors()
    var canvasHeight: Double;
    var canvasWidth: Double;
    var hue = 0.0

    @Published var m_Avoid: Double = 0.15;
    @Published var m_Align: Double = 1.0;
    @Published var m_Approach: Double = 0.09;
    @Published var birdCount: Int = 200;
    @Published var predatorCount: Int = 0;
    @Published var showTrail: Bool = false;
    @Published var showDirection: Bool = false;
    
    
    init(width: Double, height: Double){
        
        self.canvasWidth = width;
        self.canvasHeight = height;
        
        // initialize 200 birds
        for _ in 1...200 {
            let newBird = Bird(position: vector(x: Double.random(in: 10...(canvasWidth - 10)), y: Double.random(in: 10...(canvasHeight - 10))), heading: 0)
            
            birds.append(newBird)
        }
    }
    
    func update(date: TimeInterval) {
    
        // update the position and direction of every bird
        for (index, _) in birds.enumerated() {

            birds[index] = updateBirdPosition(birds[index])
            wrapAround(&birds[index])
            
            
            // add a trail if enabled
            if(showTrail) {
                birdPath.insert(Trail(position: birds[index].position, hue: hue))
                hue += 0.01
                if hue > 1 { hue -= 1 }
            }
            
        }
        
        // if enabled, remove old trails
        if(showTrail) {
            let deathDate = date - 0.7;
            for trail in birdPath {
                if trail.creationDate < deathDate {
                    birdPath.remove(trail)
                }
            }
        }
                
        for (index, _) in predators.enumerated() {
           predators[index] = updateBirdPosition(predators[index])
            wrapAround(&predators[index])
            
        }
    }
    
    func updateBirdPosition(_ bird: Bird) -> Bird {
        
        if(simStatus == .paused) {
            return bird;
        }
        
        var currentBird = bird;
        
        var heading: Double = 0;
        
        var vel = vector(0,0)
        var finalAcc = vector(0,0)
        var avoidAcc = vector(0,0)
        var velAcc = vector(0,0)
        var posAcc = vector(0,0)
        var predAcc = vector(0,0)
        
        
        avoidAcc = behaviors.adjustAccForNeighborAvoidance(currentBird: currentBird, otherBirds: birds)
        avoidAcc = avoidAcc * m_Avoid;
        
        velAcc = behaviors.adjustAccForNeighborVelocity(currentBird: currentBird, otherBirds: birds);
        velAcc = velAcc * m_Align
        
        posAcc = behaviors.adjustAccForNeighborPosition(currentBird: currentBird, otherBirds: birds);
        posAcc = posAcc * m_Approach;
        
        predAcc = behaviors.adjustAccForFleeing(currentBird: currentBird, predators: predators)
        
        
        finalAcc = finalAcc + avoidAcc;
        finalAcc = finalAcc + velAcc;
        finalAcc = finalAcc + posAcc;
        finalAcc = finalAcc + predAcc;
        
        currentBird.velocity = currentBird.velocity + finalAcc
        vel = currentBird.velocity
        
        
        
        currentBird.position = currentBird.position + vel
        
        let headingRadians = atan(vel.y/vel.x)
        heading = (headingRadians / Constants.DEG_TO_RAD) - 90;
    
        if(vel.x < 0) {
            heading += 180
        }

        currentBird.heading = heading;
        currentBird.resetAcc()
        
        return currentBird;
    }
    
    func wrapAround(_ bird: inout Bird) {
        
        let turn = 0.5;
        let dist = 10.0
        
        if bird.position.x < dist {
            bird.velocity.x += turn
        }
        
        if bird.position.x > (canvasWidth - dist) {
            bird.velocity.x -= turn
        }
        
        if bird.position.y < dist {
            bird.velocity.y += turn
        }
        
        if bird.position.y > (canvasHeight - dist) {
            bird.velocity.y -= turn
        }
        
    }
        
    public func increaseQuantity() {
        for _ in 1...5 {
            let newBird = Bird(position: vector(x: Double.random(in: 10...(canvasWidth - 10)), y: Double.random(in: 10...(canvasHeight - 10))), heading: 0)
            self.birds.append(newBird)
        }
            self.birdCount = self.birds.count
    }
    
    public func decreaseQuantity() {
        if(self.birds.count < 1) {
            return
        } else {
            self.birds.removeLast()
            self.birdCount = self.birds.count
        }
    }
    
    public func addPredator() {
        let toAdd = Bird(position: vector(x: Double.random(in: 10...(canvasWidth - 10)), y: Double.random(in: 10...(canvasHeight - 10))), heading: 0)
        
        predators.append(toAdd)
        self.predatorCount = self.predators.count;
    }
    
    public func removePredator() {
        if predators.count == 0 {return}
        predators.removeFirst();
        
        self.predatorCount = self.predators.count;
    }
    
    public func reset() {
        
        self.m_Avoid = 0.15;
        self.m_Align = 1.0;
        self.m_Approach = 0.09;
        self.birdCount = 200;
        self.predatorCount = 0;
        self.showTrail = false;
        self.showDirection = false;
        
        self.birds.removeAll()
        self.birdPath.removeAll()
        self.predators.removeAll()
        
        for _ in 1...200 {
            let newBird = Bird(position: vector(x: Double.random(in: 10...(canvasWidth - 10)), y: Double.random(in: 10...(canvasHeight - 10))), heading: 0)
            
            self.birds.append(newBird)
        }
        
        
    }
    

}

//
//  Behaviors.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/8/22.
//

import Foundation

class Behaviors {
    
    let MIN_AVOID_DIST: Double = 20;
    let DESIRED_SPEED: Double = 3;
    
    init(){}
    
    public func adjustAccForNeighborAvoidance(currentBird: Bird, otherBirds: [Bird]) -> vector {
        
        var distanceBetweenCurrAndOthers: Double;
        
        var newForce: vector;
        var desiredDir = vector(0,0);
        var diffDir = vector(0,0);
        
        for bird in otherBirds {
            
            // skip iteration if they are the same bird
            if bird.id == currentBird.id { continue }
            
            distanceBetweenCurrAndOthers = currentBird.position.distance(bird.position)
        
            if (distanceBetweenCurrAndOthers > 0 && distanceBetweenCurrAndOthers < MIN_AVOID_DIST) {
                diffDir = currentBird.position - bird.position
                diffDir.makeUnitVector()
                diffDir = diffDir / distanceBetweenCurrAndOthers
                desiredDir = desiredDir + diffDir;
            }
        }
         
        
        if (desiredDir.length() > 0) {
            desiredDir.makeUnitVector()
            desiredDir = desiredDir * DESIRED_SPEED;
            
            newForce = desiredDir - currentBird.velocity
            limitForce(&newForce)
            
           return newForce
        }
        
        return desiredDir;
        
    }
    
    public func adjustAccForNeighborPosition(currentBird: Bird, otherBirds: [Bird]) -> vector {
        
        var distanceBetweenCurrAndOthers: Double;
        
        var newForce: vector;
        var desiredPos = vector(0,0)
        var diffDir = vector(0,0);
        
        var numOfCloseBirds:Double = 0;
        
        for bird in otherBirds {
            
            // skip iteration if they are the same bird
            if bird.id == currentBird.id { continue }
            
            distanceBetweenCurrAndOthers = currentBird.position.distance(bird.position)
            
            if (distanceBetweenCurrAndOthers > 0 && distanceBetweenCurrAndOthers < MIN_AVOID_DIST) {
                
                diffDir = bird.position
                desiredPos = desiredPos + diffDir
                numOfCloseBirds += 1
                
            }
            
        }
        
        if(numOfCloseBirds == 0) {
            return desiredPos;
        }
        
        desiredPos = (desiredPos / numOfCloseBirds)
        desiredPos = desiredPos - currentBird.position
        
        if(desiredPos.length() > 0) {
            desiredPos.makeUnitVector()
            desiredPos = desiredPos * DESIRED_SPEED
            
            newForce = desiredPos - currentBird.velocity
            limitForce(&newForce)
            
            return newForce
        }
        
        return desiredPos
        
    }
    
    public func adjustAccForNeighborVelocity(currentBird: Bird, otherBirds: [Bird]) -> vector {
        
        var distanceBetweenCurrAndOthers: Double;
        
        var newForce: vector;
        var desiredVel = vector(0,0)
        
        for bird in otherBirds {
            
            // skip iteration if they are the same bird
            if bird.id == currentBird.id { continue }
            
            distanceBetweenCurrAndOthers = currentBird.position.distance(bird.position)
            
            if (distanceBetweenCurrAndOthers > 0 && distanceBetweenCurrAndOthers < MIN_AVOID_DIST) {
                desiredVel = desiredVel + bird.velocity
            }
        }
        
        if(desiredVel.length() > 0) {
            desiredVel.makeUnitVector()
            desiredVel = desiredVel * DESIRED_SPEED
            
            newForce = desiredVel - currentBird.velocity
            
            limitForce(&newForce)
            return newForce
        }
        
        return desiredVel;
        
    }
    
    public func adjustAccForFleeing(currentBird: Bird, predators: [Bird]) -> vector {
        
        var distanceBetweenCurrAndOthers: Double;
        
        var newForce: vector;
        var desiredDir = vector(0,0);
        var diffDir = vector(0,0);
        
        for predator in predators {
            
            // skip iteration if they are the same bird
            if predator.id == currentBird.id { continue }
            
            distanceBetweenCurrAndOthers = currentBird.position.distance(predator.position)
            
            
            if (distanceBetweenCurrAndOthers > 0 && distanceBetweenCurrAndOthers < 50) {
                diffDir = currentBird.position - predator.position
                diffDir.makeUnitVector()
                desiredDir = desiredDir + diffDir;
            }
        }
        
        if (desiredDir.length() > 0) {
               // Set average vector to the length of the desired speed
               desiredDir.makeUnitVector();
               desiredDir = desiredDir * 30;
               // Reynolds defined steering force as: desired vel - curr vel
               newForce = desiredDir - currentBird.velocity;
               limitForce(&newForce);
            
               return newForce;
           }

           return desiredDir;
        
    }
    
    public func limitForce(_ force: inout vector) {
        let MAX_FORCE: Double = 0.5;
        
        if(force.length() > MAX_FORCE) {
            force.makeUnitVector()
            force = force * MAX_FORCE;
        }
    }
    
    
}

public extension vector {
    
    internal func distance(_ other: vector) -> Double {
        return (((self.x - other.x) * (self.x - other.x)) + ((self.y - other.y) * (self.y - other.y))).squareRoot()
    }
    
    internal func length() -> Double {
        return ((self.x * self.x) + (self.y * self.y)).squareRoot()
    }
    
    internal mutating func makeUnitVector() {
        
        let magnitud: Double = ((self.x * self.x) + (self.y * self.y)).squareRoot();
        
        self.x = (self.x/magnitud)
        self.y = (self.y/magnitud)
    }
}

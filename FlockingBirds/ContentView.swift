//
//  ContentView.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/7/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var simulation: SimulationController = SimulationController(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    
    @State var showSettings: Bool = false;
    
    var body: some View {
        NavigationView {
            ZStack {
                TimelineView(.animation) { timeline in
                    Canvas { context, size in
                        let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                        
                        simulation.update(date: timelineDate)

                        // Paint each bird
                        for bird in simulation.birds {
        
                            var birdContext = context;
                            
                            // Move the context to the position of the bird
                            birdContext.translateBy(x: bird.position.x, y: bird.position.y)
                            
                            // Rotate based on the bird heading
                            birdContext.rotate(by: Angle(degrees: bird.heading))
            
                            // Paint the bird
                            birdContext.draw(simulation.birdImage, at: CGPoint(x: 0, y: 0))
                            
                            // Paint Heading
                            if !simulation.showDirection { continue }
                            
                            var heading = Path()
                            heading.move(to: CGPoint(x: 0, y: 3))
                            heading.addLine(to: CGPoint(x: 0, y: 15))
                            
                            birdContext.stroke(heading, with: .color(.blue), lineWidth: 0.2)
                            
                        }
                        
                        // Paint each predator
                        for predator in simulation.predators {
                            var predatorContext = context;
                            
                            predatorContext.translateBy(x: predator.position.x, y: predator.position.y)
                            
                            predatorContext.rotate(by: Angle(degrees: predator.heading))
                
                            predatorContext.draw(simulation.predatorImage, at: CGPoint(x: 0, y: 0))
                        }
                        
                        // Paint trail if true
                        if !simulation.showTrail { return }
                        for path in simulation.birdPath {
                            var pathContext = context;
                            
                            pathContext.opacity = 0.7 - (timelineDate - path.creationDate)
                            
                            pathContext.addFilter(.colorMultiply(Color(hue: path.hue, saturation: 1, brightness: 1)))
                            pathContext.opacity = 1 - (timelineDate - path.creationDate)
                            
                            pathContext.fill(Path(ellipseIn: CGRect(x: path.position.x, y: path.position.y, width: 1, height: 1)), with: .color(.white))
                            
                        }
                    }
                }
                .ignoresSafeArea()
                .background(.white)
                .onAppear {
                    simulation.simStatus = .running
                }
                BottomBar(simulation: simulation, showSettings: $showSettings)
                
            }
            .sheet(isPresented: $showSettings) {
                Settings(simulation: simulation)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

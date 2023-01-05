//
//  Settings.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/8/22.
//

import SwiftUI

struct Settings: View {
    
    @StateObject var simulation: SimulationController;
    @State var sliderValue : Double = 0.0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Behaviors")
                    .font(.largeTitle)
                    .fontWeight(.black)) {
                        BehaviourModifier(name: "Avoidance", description: "Control how quickly they steer away with the Avoidance slider.", sliderValue: $simulation.m_Avoid, min: 0, max: 1)
                        BehaviourModifier(name: "Alignment", description: "Control how quickly they try to match the vectors of its neighboors using the alignment slider", sliderValue: $simulation.m_Align, min: 0, max: 1)
                        BehaviourModifier(name: "Approach", description: "Each bird flies towards the other bird. But they don't just immediately fly directly at each other. They gradually steer towards each other at a rate that you can adjust with the Approach slider", sliderValue: $simulation.m_Approach, min: 0, max: 1)
                    }
                Section(header: Text("Birds").font(.largeTitle)
                    .fontWeight(.black)) {
                        HStack {
                            Button(action: {
                                simulation.increaseQuantity()
                            }) {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Spacer()
                            Text("\(simulation.birds.count)")
                                .font(.title)
                                .fontWeight(.regular)
                            Spacer()
                            Button(action: {
                                simulation.decreaseQuantity()
                                print("increased quantity UI")
                            }){
                                Image(systemName: "minus")
                                    .imageScale(.large)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                Section(header: Text("Predators").font(.largeTitle)
                    .fontWeight(.black)) {
                        HStack {
                            Button(action: {
                                simulation.addPredator()
                            }) {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Spacer()
                            Text("\(simulation.predators.count)")
                                .font(.title)
                                .fontWeight(.regular)
                            Spacer()
                            Button(action: {
                                simulation.removePredator()
                                print("increased quantity UI")
                            }){
                                Image(systemName: "minus")
                                    .imageScale(.large)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                Section(header: Text("Trail").font(.largeTitle)
                    .fontWeight(.black)) {
                        Toggle("Display trail", isOn: $simulation.showTrail)
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                    }
                Section(header: Text("Direction").font(.largeTitle)
                    .fontWeight(.black)) {
                        Toggle("Display Direction", isOn: $simulation.showDirection)
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                    }
                Section {
                    Button("Reset simulation") {
                        simulation.reset()
                        
                    }
                }
            }
        }
        .background(.white)
        .foregroundColor(Color.red)
        .onDisappear {
            simulation.simStatus = .running
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(simulation: SimulationController(width: 393.0, height: 852.0))
    }
}

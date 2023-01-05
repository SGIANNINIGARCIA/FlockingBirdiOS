//
//  BottomBar.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/9/22.
//

import SwiftUI

struct BottomBar: View {
    
    @StateObject var simulation: SimulationController;
    @Binding var showSettings: Bool;
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            Button(action: {
                showSettings = true;
                simulation.simStatus = .paused
            }, label: {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                    Text("Settings")
                }
                .padding()
                .foregroundColor(.red)
                .frame(width: 128, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.red, lineWidth: 1)
                )
                .background(Color.white)
        
            })
            Spacer()
            BehaviourValueDisplay(simulation: simulation)
        }
        .padding(.leading, 32)
        .padding(.trailing, 16)
        .position(x: (UIScreen.main.bounds.size.width/2) - 8, y: UIScreen.main.bounds.size.height - 150)
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar(simulation: SimulationController(width: 393.0, height: 852.0), showSettings: .constant(false))
    }
}

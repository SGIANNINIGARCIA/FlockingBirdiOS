//
//  BehaviourValueDisplay.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/10/22.
//

import SwiftUI

struct BehaviourValueDisplay: View {
    
    @StateObject var simulation: SimulationController;
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
                    .foregroundColor(Color.red)
                Spacer()
                Text(String(format: "%.2f", simulation.m_Avoid))
                    .foregroundColor(Color.red)
            }
            Spacer()
            HStack{
                Image(systemName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left")
                    .foregroundColor(Color.red)
                Spacer()
                Text(String(format: "%.2f", simulation.m_Approach))
                    .foregroundColor(Color.red)
            }
            Spacer()
            HStack{
                Image(systemName: "arrow.triangle.pull")
                    .foregroundColor(Color.red)
                Spacer()
                Text(String(format: "%.2f", simulation.m_Align))
                    .foregroundColor(Color.red)
            }
            .padding(.leading, 8)
            Spacer()
            HStack{
                Image(systemName: "bird.fill")
                    .foregroundColor(Color.red)
                Spacer()
                Text("\(simulation.birdCount)")
                    .foregroundColor(Color.red)
            }
        }
        .padding(.all)
        .frame(width: 110, height: 130)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.red, lineWidth: 1)
        )
    }
}

struct BehaviourValueDisplay_Previews: PreviewProvider {
    static var previews: some View {
        BehaviourValueDisplay(simulation: SimulationController(width: 393.0, height: 852.0))
    }
}

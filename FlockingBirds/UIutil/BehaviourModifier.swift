//
//  BehaviourModifier.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/10/22.
//

import SwiftUI

struct BehaviourModifier: View {
    
    @State var name: String;
    @State var description: String;
    @Binding var sliderValue: Double;
    var min: Double;
    var max: Double;
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(String(format: "%.2f", sliderValue))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 30)
                    .background(Color.red)
                    .cornerRadius(16)
                
                
            }
            .padding(.bottom, 2)
            Text(description)
            Slider(value: $sliderValue, in: min...max) {
                Text("Slider")
            } minimumValueLabel: {
                Text(String(format: "%.2f", min)).font(.title2).fontWeight(.regular)
            } maximumValueLabel: {
                Text(String(format: "%.2f", max)).font(.title2).fontWeight(.regular)
            }.tint(.red)
                .padding()
        }
    }
}

struct BehaviourModifier_Previews: PreviewProvider {
    static var previews: some View {
        BehaviourModifier(name: "Aproach", description: "Each bird flies towards the other bird. But they don't just immediately fly directly at each other. They gradually steer towards each other at a rate that you can adjust with the Approach slider", sliderValue: .constant(Double(0.5)), min: 0, max: 1)
    }
}

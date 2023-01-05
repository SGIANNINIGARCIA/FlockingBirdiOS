//
//  Bird.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/7/22.
//

import Foundation
import SwiftUI

typealias vector = SIMD2<Double>

struct Bird: Hashable {
    
    let id = UUID()
    var position: vector;
    var ahead: vector;
    var acceleration = vector(0,0)
    var velocity = vector(Double.random(in: -1...1), Double.random(in: -1...1))
    var heading: Double;
    
    init(position: vector, heading: Double) {
        self.position = position
        self.ahead = vector(position.x + 1, position.y + 1)
        self.heading = heading
    }
    
    mutating func resetAcc() {
        self.acceleration = vector(0,0)
    }
    
    mutating func resetVel() {
        self.velocity = vector(0.1,0.1)
    }
    
    static func == (lhs: Bird, rhs: Bird) -> Bool {
        return lhs.id == rhs.id
    }
}

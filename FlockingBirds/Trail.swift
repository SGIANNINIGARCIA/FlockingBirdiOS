//
//  Trail.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/9/22.
//

import Foundation

struct Trail: Hashable {
    let position: vector;
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
    
}

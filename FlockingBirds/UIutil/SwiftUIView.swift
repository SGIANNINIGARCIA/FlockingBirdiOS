//
//  SwiftUIView.swift
//  FlockingBirds
//
//  Created by Sandro Giannini on 12/11/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    var one = vector(3, 2)
    var two = vector(6, 7)
    
    var three: vector;
    
    var arrayTest: [Int];
    
    init() {
        self.three = one - two;
        self.arrayTest = [Int]();
        self.arrayTest.append(4)
        
        
    }
    
    var body: some View {
        Text("js")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

//
//  DialNumbers.swift
//  DialLock
//
//  Created by Developer on 30.06.2024.
//

import SwiftUI

struct DialNumber: View {
    let index: Int
    let number: Int
    let radius: Double

    
    var body: some View {
        Text("\(number)")
            .font(.title2.bold())
            .foregroundStyle(.white)
            .position(
                x: DialHelper.calcX(index, radius: radius),
                y: DialHelper.calcY(index, radius: radius)
            )
    }
}

#Preview {
    DialNumber(
        index: 0,
        number: 1,
        radius: 150.0
    )
}

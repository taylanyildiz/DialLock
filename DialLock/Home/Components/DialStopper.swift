//
//  DialHolder.swift
//  DialLock
//
//  Created by Developer on 30.06.2024.
//

import SwiftUI

struct DialStopper: View {
    let radius: Double
    private var index: Int { 10 }
    
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 30, height: 30)
            .position(
                x: DialHelper.calcX(index, radius: radius),
                y: DialHelper.calcY(index, radius: radius)
            )
    }
}

#Preview {
    DialStopper(radius: 50)
}

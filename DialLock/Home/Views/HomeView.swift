//
//  HomeView.swift
//  DialLock
//
//  Created by Developer on 30.06.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var pins: String = ""
    private var correctPins: String = "1234"
    
    private var numbers: Array = Array(0..<10).map { $0 == 0 ? $0 : 10 - $0}.reversed()
    private var radius: Double = 150.0
    
    private func calcAngle(_ index: Int) -> Angle {
        Angle.degrees(Double(index + 1) * (-Double.pi / 6))
    }
    

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter\nPasscode")
                .font(.system(size: 40, weight: .heavy))
                .textCase(.uppercase)
            DialPin(pins: $pins, correctPins: correctPins)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
            ZStack(alignment: .center) {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 80.0))
                DialStopper(radius: radius)
                ForEach(0..<numbers.count, id: \.self) { index in
                    DialNumber(index: index, number: numbers[index], radius: radius)
                }
                DialHolder(radius: radius, lineWidth: 80, numbers: numbers, text: $pins)
            }
            .frame(width: radius * 2, height: radius * 2)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}

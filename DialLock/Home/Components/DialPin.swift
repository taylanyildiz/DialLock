//
//  DialPin.swift
//  DialLock
//
//  Created by Developer on 30.06.2024.
//

import SwiftUI



struct DialPin: View {
    
    @Binding var pins: String
    let correctPins: String
    
    private var length: Int { 4 }
    private var radius: Double { 10.0 }
    @State private var color: Color = .white
    
    private func hasValue(_ index: Int) -> Bool {
        return index <= pins.count - 1 && pins.splitter()[index] != ""
    }
    
    var body: some View {
        HStack(spacing: 5.0) {
            ForEach(0..<length, id: \.self) { index in
                Circle()
                    .foregroundStyle(.black)
                    .frame(width: radius * 2, height: radius * 2)
                    .overlay(
                        Circle()
                            .fill(color)
                            .padding(3)
                            .scaleEffect(hasValue(index) ? 1.0 : 0.0)
                            .animation(.easeIn, value: hasValue(index))
                    )
            }
        }
        .onChange(of: pins) { oldValue, newValue in
            if newValue.count != 4 { return }
            let correct = newValue == correctPins
            
            withAnimation {
                color = correct ? .green : .red
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                pins = ""
                color = .white
           }
        }
    }
}

#Preview {
    DialPin(pins: .constant(""), correctPins: "")
}

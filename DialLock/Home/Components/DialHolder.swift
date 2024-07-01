//
//  DialoHolder.swift
//  DialLock
//
//  Created by Developer on 30.06.2024.
//

import SwiftUI

struct DialHolder: View {
    let radius: Double
    let lineWidth: Double
    let numbers: Array<Int>
    @Binding var text: String
    
    
    private var colorHolder: Color { Color.white }
    private var lineWidthCalc: Double { lineWidth - 10.0 }
    private var dialRaidus: Double { lineWidthCalc / 2 - 8.0}
    private var center: CGPoint { CGPoint(x: radius, y: radius) }
    private let tolerance: Angle = .degrees(1)
    
    @State private var selectedNumber: Int = -1
    @State private var rotation: Angle = .zero
    @State private var initialRotation: Angle = .zero
    @State private var catched: Bool = false
  
    
    
    
    private func findNumber(_ angle: Angle) -> Void {
        selectedNumber = -1
        let degrees = DialHelper.holderDegrees(angle)
        for number in 0 ..< numbers.count {
            let numberDegrees = DialHelper.numberAngle(number).degrees
            if abs(numberDegrees - degrees) <= dialRaidus / 3 {
                // Finded number
                selectedNumber = number
            }
        }
    }
    
    // Update Gesture
    func onChangedGesture(_ value: DragGesture.Value ) -> Void {
        if catched { return }
        // Started Gesture
        self.onStartedGesture(value)
        
        // Check selected number
        if selectedNumber == -1 { return }

        let currentRotation = (value.location - center).angle()
        let delta = currentRotation - initialRotation
        let newRotation = rotation + delta
        
        // Holder rotation
        let holderRotation: Angle = .radians(.pi / 6) + DialHelper.numberAngle(selectedNumber)
        
        // Is holder catched
        catched = abs(newRotation.radians.truncatingRemainder(dividingBy: 2 * .pi) - holderRotation.radians) < tolerance.radians
        
        if catched {
            text = text + selectedNumber.description
            return
        }
        
        
        if delta.radians > 0 && !catched { rotation = newRotation }
        
        initialRotation = currentRotation
    }
    
    // Start Gesture
    func onStartedGesture(_ value: DragGesture.Value) -> Void {
        if initialRotation == .zero {
            let startLocation = value.startLocation
            initialRotation = (startLocation - center).angle()
            findNumber(initialRotation)
        }
    }
    
    
    // End Gesture
    func onEndedGesture(_ value: DragGesture.Value? = nil) -> Void {
        withAnimation {
            rotation = .zero
        }
        initialRotation = .zero
        catched = false
    }
    
    var body: some View {
        Circle()
            .trim(
                from: DialHelper.calcArc(9),
                to: DialHelper.calcArc(0)
            )
            .stroke(colorHolder, style: StrokeStyle(lineWidth: lineWidthCalc, lineCap: .round))
            .mask {masked()}
            .rotationEffect(rotation)
            .gesture(
                DragGesture()
                    .onChanged(onChangedGesture)
                    .onEnded(onEndedGesture)
            )
            .frame(width: radius * 2, height: radius * 2)

    }
}


extension DialHolder {
    private func masked() -> some View {
        Circle()
            .trim(
                from: DialHelper.calcArc(9),
                to: DialHelper.calcArc(0)
            )
            .stroke(colorHolder, style: StrokeStyle(lineWidth: lineWidthCalc, lineCap: .round))
            .overlay {
                ForEach(0..<numbers.count, id: \.self) { index in
                    Circle()
                        .frame(width: dialRaidus * 2, height: dialRaidus * 2)
                        .blendMode(.destinationOut)
                        .position(
                            x: DialHelper.calcX(index, radius: radius),
                            y: DialHelper.calcY(index, radius: radius)
                        )
                }
            }
    }
}

#Preview {
    DialHolder(
        radius: 140,
        lineWidth: 80.0,
        numbers: Array(0..<10).map { $0 == 0 ? $0 : 10 - $0},
        text: .constant("")
    )
}

//
//  DialHelper.swift
//  DialLock
//
//  Created by Developer on 30.06.2024.
//

import Foundation
import SwiftUI


/// Dial Lock Helper
final class DialHelper {
    
    static private var references: Double  { Double.pi / 6 }
    
    static private var totalDegrees: Double { Double.pi * 2 }
    
    /// Calculate Angle for Dial with [index]
    /// references [ pi / 6 ]
    static public func calcAngle(_ index: Int) -> Angle {
        Angle.degrees(Double(index + 1) * -references)
    }
    
    static public func calcX(_ index: Int, radius: Double) -> Double {
        let angle = calcAngle(index)
        return cos(angle.degrees) * radius + radius
    }
    
    static public func calcY(_ index: Int, radius: Double) -> Double {
        let angle = calcAngle(index)
        return sin(angle.degrees) * radius + radius
    }
    
    static public func calcArc(_ index: Int) -> Double {
        let degrees = calcAngle(index).degrees
        return 1 + ( degrees / totalDegrees )
    }
    
    static public func numberAngle(_ number: Int) -> Angle {
        var number = number
        if number == 0 { number = 10 }
        return Angle.radians(Double(number) * references)
    }
    
    
    static public func holderDegrees(_ angle: Angle) -> Double {
        var degrees = angle.degrees
        if degrees > 0 {
            degrees = 360 - degrees
        } else {
            degrees = -degrees
        }
        return degrees
    }
    
}

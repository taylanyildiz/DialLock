//
//  CGPointExtensisons.swift
//  DialLock
//
//  Created by Developer on 1.07.2024.
//

import Foundation
import SwiftUI

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    func direction() -> Double {
        Double(atan2(y, x))
    }
    
    func angle() -> Angle {
        Angle(radians: direction())
    }
}

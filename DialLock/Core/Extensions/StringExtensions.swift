//
//  StringExtensions.swift
//  DialLock
//
//  Created by Developer on 1.07.2024.
//

import Foundation


extension String {
    func splitter() -> [String] {
        map({ String($0) }).joined(separator: ",").components(separatedBy: ",")
    }
}

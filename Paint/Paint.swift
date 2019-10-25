//
//  Paint.swift
//  Paint
//
//  Created by Julio Barrera on 08/10/19.
//  Copyright © 2019 Julio Barrera. All rights reserved.
//

import UIKit.UIColor

struct Paint {
    var red: Float
    var green: Float
    var blue: Float
    
    init(red: Float, green: Float, blue: Float) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init() {
        self.red = 0
        self.green = 0
        self.blue = 0
    }
}

extension Paint {
    
    private static func clamp(_ input: Float) -> Float {
        min(max(input, 0), 1)
    }
    
    mutating func brighten() {
        red = Self.clamp(red + 0.1)
        green = Self.clamp(green + 0.1)
        blue = Self.clamp(blue + 0.1)
    }
    
    mutating func darken() {
        red = Self.clamp(red - 0.1)
        green = Self.clamp(green - 0.1)
        blue = Self.clamp(blue - 0.1)
    }
    
    mutating func randomize() {
        red = Float.random(in: 0...1)
        green = Float.random(in: 0...1)
        blue = Float.random(in: 0...1)
    }
    
    private static func toHexString(_ input: Float, prefix: Bool = true) -> String {
        let value = UInt8(input * Float(255).rounded(.down))
        return prefix ? String(format: "0x%02X", value) : String(format: "%02X", value)
    }
    
    var redHex: String { Self.toHexString(red) }
    var greenHex: String { Self.toHexString(green) }
    var blueHex: String { Self.toHexString(blue) }
    
    var hex: String {
        redHex + Self.toHexString(green, prefix: false) + Self.toHexString(blue, prefix: false)
    }
    
    var color: UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}

extension Paint: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.red == rhs.red &&
            lhs.green == rhs.green &&
            lhs.blue == rhs.blue
    }
}

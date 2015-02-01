//
//  RenderInnerFunction.swift
//  SwiftResistanceSwift
//
//  Created by Joseph on 01/02/2015.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

typealias Byte = UInt8

public struct Pixel {
    var red: Byte
    var green: Byte
    var blue: Byte
    var alpha: Byte
}

public struct RenderBuffer {
    var pixels: [Pixel]
    var width: Int
    var height: Int
    
    public init(width: Int, height: Int) {
        assert(width > 0)
        assert(height > 0)
        
        let pixel = Pixel(red: 0, green: 0, blue: 0, alpha: 0xFF)
        pixels = [Pixel](count: width * height, repeatedValue: pixel)
        
        self.width = width
        self.height = height
    }
}

public func RenderGradient(inout buffer: RenderBuffer, offsetX: Int, offsetY: Int)
{
    let height = buffer.height
    let width = buffer.width
    buffer.pixels.withUnsafeMutableBufferPointer { pixels->() in
        for y in 0..<height {
            let row = y * width
            for x in 0..<width {
                let i = row + x
                pixels[i].green = Byte((y + offsetY) & 0xFF)
                pixels[i].blue = Byte((x + offsetX) & 0xFF)
            }
        }
    }
}
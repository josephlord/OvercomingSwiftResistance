//
//  Pointer.swift
//  SwiftResistanceSwift
//
//  Created by David Owens II on 1/30/15.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

import Foundation

struct Pixel {
    var red: Byte
    var green: Byte
    var blue: Byte
    var alpha: Byte
}

struct RenderBuffer {
    var pixels: [Pixel]
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        assert(width > 0)
        assert(height > 0)
        
        let pixel = Pixel(red: 0, green: 0, blue: 0, alpha: 0xFF)
        pixels = [Pixel](count: width * height, repeatedValue: pixel)
        
        self.width = width
        self.height = height
    }
}

func RenderGradient(inout buffer: RenderBuffer, offsetX: Int, offsetY: Int)
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

func pixelArrayTest(iterations: Int) -> Float {
    
    let start = mach_absolute_time()
    
    var buffer = RenderBuffer(width: 960, height: 540)
    
    for (var i = 0; i < iterations; ++i) {
        RenderGradient(&buffer, i, i * 2);
    }
    
    return Float(mach_absolute_time() - start) / Float(NSEC_PER_SEC)
}

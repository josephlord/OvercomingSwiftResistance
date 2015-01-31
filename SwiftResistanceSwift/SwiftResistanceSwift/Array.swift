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
    // I truly hope you have turned down the number of iterations or you have picked
    // up a new build of Swift where this is not dog slow with -Onone.
    var offset = 0
    for (var y = 0, height = buffer.height; y < height; ++y) {
        for (var x = 0, width = buffer.width; x < width; ++x) {
            let pixel = Pixel(
                red: 0,
                green: Byte((y + offsetY) & 0xFF),
                blue: Byte((x + offsetX) & 0xFF),
                alpha: 0xFF)
            buffer.pixels[offset] = pixel;
            ++offset;
        }
    }
    
    // Turn this code on for at least some sanity back to your debug builds. It's still
    // going to be slow, but at compared to the code above, it's going to feel glorious.
    //        buffer.pixels.withUnsafeMutableBufferPointer { (inout p: UnsafeMutableBufferPointer<Pixel>) -> () in
    //            var offset = 0
    //            for (var y = 0, height = buffer.height; y < height; ++y) {
    //                for (var x = 0, width = buffer.width; x < width; ++x) {
    //                    let pixel = Pixel(
    //                        red: 0,
    //                        green: Byte((y + offsetY) & 0xFF),
    //                        blue: Byte((x + offsetX) & 0xFF),
    //                        alpha: 0xFF)
    //                    p[offset] = pixel
    //                    ++offset;
    //                }
    //            }
    //        }
}

func pixelArrayTest(iterations: Int) -> Float {
    
    let start = mach_absolute_time()
    
    var buffer = RenderBuffer(width: 960, height: 540)
    
    for (var i = 0; i < iterations; ++i) {
        RenderGradient(&buffer, i, i * 2);
    }
    
    return Float(mach_absolute_time() - start) / Float(NSEC_PER_SEC)
}

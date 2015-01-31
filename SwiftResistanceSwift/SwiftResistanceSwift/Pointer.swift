//
//  Pointer.swift
//  SwiftResistanceSwift
//
//  Created by David Owens II on 1/30/15.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

import Foundation

func unsafeMutablePointerTest(iterations: Int) -> Float {
    struct Pixel {
        var red: Byte
        var green: Byte
        var blue: Byte
        var alpha: Byte
    }

    struct RenderBuffer {
        var pixels: UnsafeMutablePointer<Pixel>
        var width: Int
        var height: Int
        
        init(width: Int, height: Int) {
            assert(width > 0)
            assert(height > 0)

            pixels = UnsafeMutablePointer.alloc(width * height * sizeof(Pixel))

            self.width = width
            self.height = height
        }
        
        mutating func release() {
            pixels.dealloc(width * height * sizeof(Pixel))
            width = 0
            height = 0
        }
    }

    func RenderGradient(var buffer: RenderBuffer, offsetX: Int, offsetY: Int)
    {
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
    }

    let start = mach_absolute_time()

    var buffer = RenderBuffer(width: 960, height: 540)

    for (var i = 0; i < iterations; ++i) {
        RenderGradient(buffer, i, i * 2);
    }

    buffer.release()

    return Float(mach_absolute_time() - start) / Float(NSEC_PER_SEC)
}

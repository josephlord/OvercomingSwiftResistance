//
//  Pointer.swift
//  SwiftResistanceSwift
//
//  Created by David Owens II on 1/30/15.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

import Foundation
import PerformanceCritical


func pixelArrayTest(iterations: Int) -> Float {
    
    let start = mach_absolute_time()
    
    var buffer = RenderBuffer(width: 960, height: 540)
    
    for (var i = 0; i < iterations; ++i) {
        RenderGradient(&buffer, i, i * 2);
    }
    
    return Float(mach_absolute_time() - start) / Float(NSEC_PER_SEC)
}

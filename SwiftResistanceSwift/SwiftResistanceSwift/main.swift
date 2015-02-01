//
//  main.swift
//  SwiftResistanceSwift
//
//  Created by David Owens II on 1/30/15.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

import Foundation

let NUMBER_OF_ITERATIONS = 100

#if DEBUG
let BASELINE: Float = 0.099769
#else
let BASELINE: Float = 0.020427
#endif

func timing(samples: Int, iterations: Int, fn: (Int) -> Float) -> (avg: Float, stddev: Float, diff: Int) {
    var timings = [Float](count: samples, repeatedValue: 0.0)
    for s in 0..<samples {
        timings[s] = fn(iterations)
    }
    
    let avg = reduce(timings, 0.0, +) / Float(samples)
    
    let sums = reduce(timings, 0.0) { sum, x in ((x - avg) * (x - avg)) + sum }
    let stddev = sqrt(sums / Float(timings.count - 1))
    let diff = Int(((BASELINE - avg) / BASELINE * 100.0) + 0.5)
    return (avg, stddev, diff)
}

println("Swift Rendering Tests: \(NUMBER_OF_ITERATIONS) iterations per test")
println("---------------------")

let timing1 = timing(10, NUMBER_OF_ITERATIONS) { n in unsafeMutablePointerTest(n) }
println("UnsafeMutablePointer<Pixel> avg time: \(timing1.avg)s, stddev: \(timing1.stddev)s, diff: \(timing1.diff)%")

let timing2 = timing(10, NUMBER_OF_ITERATIONS) { n in pixelArrayTest(n) }
println("[Pixel] avg time: \(timing2.avg)s, stddev: \(timing2.stddev)s, diff: \(timing2.diff)%")

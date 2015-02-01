# Optimisation Notes

This relates to http://owensd.io/2015/01/31/swift-resistance-explored.html

I don't dispute that Debug Swift is slow, this isn't news to me. I talked about it back in October: http://blog.human-friendly.com/swift-optimisation-again-slides-from-swift-london-21st-october-2014 but I do think it can be worked around and personally I would rather take the 80% speedup in release over Objective-C and accept the 36 times slower debug compared with objective-c (327 times slower than optimised Swift).

Initially Obj-C (Os) and Swift (-O) are almost identical times whether using multable array or not. (0.022)

I've separated the the array code into separate functions rather defining everything within a toplevel function.

My plan of development is first to make the optimised version as fast as possible then see what I can do about the debug build.

Update to `withUnsafeMutableBufferPointer` and `for x in 0..<width`. Speed up to 0.013 (optimised -O)

Switch to 100 iterations for more stability in optimised results. Optimised Swift is 84% faster than the Objective-C Code

Objc (-Os) 0.077(1.8) 	    Swift -O [Pixel] 0.042 (1)

Objc (-O0) 0.38 (9.1)	      Swift -ONone [Pixel] 13.8 (327)


Split into framework. Working but lots of warnings about duplication of Swift Library functions like this:
objc[86446]: Class _TtC6AppKit15REPLApplication is implemented in both /Users/josephl/Library/Developer/Xcode/DerivedData/SwiftResistanceSwift-gvtjeqrlaieihehdoynetptwibsp/Build/Products/Debug/PerformanceCritical.framework/Versions/A/Frameworks/libswiftAppKit.dylib and /Users/josephl/Library/Developer/Xcode/DerivedData/SwiftResistanceSwift-gvtjeqrlaieihehdoynetptwibsp/Build/Products/Debug/SwiftResistanceSwift. One of the two will be used. Which one is undefined.

With the library compiled with -O the rest of the application can be compiled with -Onone and still complete in 0.043 for 100 iterations.

Returning to 30 iterations for proper comparison.

Obj-C -Os 0.027     Swift -O 0.014

Obj-C -O0 0.11      Swift -ONone 0.014 

Note that this is effectively cheating by wrapping the critical code in a framework but if this allows the bulk of the project to be debugable this is a worthwhile tradeoff. This is definitely a workaround but one that can be effective. Not sure how to get rid of the warnigns.

Added a monolithic build target with debug (very slow) and optimised schemes to go with it. 

Note all timings taken on:

MacBook Pro11,3

Intel Core i7 2.3GHz 4 core L2 256KB/core L3 6MB 16GB RAM 
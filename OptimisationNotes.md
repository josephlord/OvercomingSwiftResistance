Optimisation Notes

Initially Obj-C (Os) and Swift (-O) are almost identical times whether using multable array or not. (0.022)

I've separated the the array code into separate functions rather defining everything within a toplevel function.

My plan of development is first to make the optimised version as fast as possible then see what I can do about the debug build.

Update to `withUnsafeMutableBufferPointer` and `for x in 0..<width`. Speed up to 0.013 (optimised -O)

Switch to 100 iterations for more stability in optimised results. Optimised Swift is 84% faster than the Objective-C Code
Objc (-Os) 0.077(1.8) 	    Swift -O [Pixel] 0.042 (1)
Objc (-O0) 0.38 (9.1)	      Swift -ONone [Pixel] 13.8 (327)

1.83979213101241	1
9.0996686318213	326.72333954698


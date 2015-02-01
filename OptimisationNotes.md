Optimisation Notes

Initially Obj-C (Os) and Swift (-O) are almost identical times whether using multable array or not. (0.022)

I've separated the the array code into separate functions rather defining everything within a toplevel function.

My plan of development is first to make the optimised version as fast as possible then see what I can do about the debug build.

Update to `withUnsafeMutableBufferPointerz and `for x in 0..<width`. Speed up to 0.013 (optimised -O)
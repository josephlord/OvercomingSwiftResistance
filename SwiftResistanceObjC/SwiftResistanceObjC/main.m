//
//  main.m
//  SwiftResistanceObjC
//
//  Created by David Owens II on 1/30/15.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    uint8_t red;
    uint8_t blue;
    uint8_t green;
    uint8_t alpha;
} Pixel;

typedef struct {
    Pixel *pixels;
    int width;
    int height;
} RenderBuffer, *RenderBufferRef;

RenderBufferRef RenderBufferCreate(int width, int height)
{
    assert(width > 0);
    assert(height > 0);
    
    RenderBufferRef buffer = malloc(sizeof(RenderBuffer));
    assert(buffer);

    buffer->pixels = malloc(width * height * sizeof(Pixel));
    assert(buffer->pixels);
    
    buffer->width = width;
    buffer->height = height;
    
    return buffer;
}

void RenderBufferRelease(RenderBufferRef buffer)
{
    if (buffer->pixels) {
        free(buffer->pixels);
    }
    
    buffer->width = 0;
    buffer->height = 0;
}

void RenderGradient(RenderBufferRef buffer, int offsetX, int offsetY)
{
    int offset = 0;
    for (int y = 0, height = buffer->height; y < height; ++y) {
        for (int x = 0, width = buffer->width; x < width; ++x) {
            Pixel pixel = { 0, y + offsetY, x + offsetX, 0xFF };
            buffer->pixels[offset] = pixel;
            ++offset;
        }
    }
}


int main(int argc, const char * argv[]) {
    uint64_t start = mach_absolute_time();
    
    RenderBufferRef buffer = RenderBufferCreate(960, 540);
    
    const int NUMER_OF_ITERATIONS = 100;
    for (int i = 0; i < NUMER_OF_ITERATIONS; ++i) {
        RenderGradient(buffer, i, i * 2);
    }
    
    RenderBufferRelease(buffer);
    
    uint64_t elapsed = mach_absolute_time() - start;
    printf("elapsed time: %fs\n", (float)elapsed / NSEC_PER_SEC);
    
    return 0;
}

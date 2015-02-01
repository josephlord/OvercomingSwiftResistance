//
//  RenderGradient.m
//  SwiftResistanceObjC
//
//  Created by David Owens II on 1/31/15.
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

void RenderGradient(RenderBufferRef buffer, int offsetX, int offsetY);

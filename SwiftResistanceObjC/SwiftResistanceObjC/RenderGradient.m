//
//  RenderGradient.m
//  SwiftResistanceObjC
//
//  Created by David Owens II on 1/31/15.
//  Copyright (c) 2015 David Owens II. All rights reserved.
//

#import "RenderGradient.h"

void RenderGradient(RenderBufferRef buffer, int offsetX, int offsetY)
{
    int width = buffer->width + offsetY;
    int height = buffer->height + offsetX;
    uint32_t *pixel = (uint32_t *)&buffer->pixels[0];
    
    for (int y = offsetY; y < height; ++y) {
        for (int x = offsetX; x < width; ++x) {
            *pixel = 0xFF << 24 | x << 16 | y << 8 | 0xAD;
            ++pixel;
        }
    }
}
//
//  bridge.h
//  GraphicsDemo
//
//  Created by Ahmet Göksu on 25.08.2024.
//

#ifndef bridge_h
#define bridMge_h
// bridge.h
#include <ft2build.h>
#include "grobjs.h"

// Declare functions that you need from your C code to use in Swift
int grNewBitmap(grPixelMode pixel_mode, int num_grays, int width, int height, grBitmap* bit);
void grDoneBitmap(grBitmap* bit);
void* grAlloc(size_t size);
void grFree(const void* block);

#endif /* bridge_h */

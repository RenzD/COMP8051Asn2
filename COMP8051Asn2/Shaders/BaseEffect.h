//
//  BaseEffect.h
//  HelloOpenGL
//
//  Created by Ray Wenderlich on 9/3/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Vertex.h"

@import GLKit;

@interface BaseEffect : NSObject

@property (nonatomic, assign) GLuint programHandle;
@property (nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (assign) GLKTextureInfo* texture;
@property (assign) GLKVector4 matColour;
@property (assign) float dayNightFactor;
@property (assign) GLuint dayNightFactorUniform;
@property (assign) GLKVector2 viewportUniform;
@property (assign) bool flashlightActive;

- (id)initWithVertexShader:(NSString *)vertexShader
            fragmentShader:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end

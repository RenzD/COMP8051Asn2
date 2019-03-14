//
//  TopFace.m
//  COMP8051Asn2
//
//  Created by Student on 2019-03-12.
//  Copyright © 2019 BCIT. All rights reserved.
//

#import "TopFace.h"

@implementation TopFace
const Vertex Vertices4[] = {
    // Top
    {{1, 1, 1},  {1,1,1,1}, {1, 0}, {0, 1, 0}}, // 16
    {{1, 1, -1},  {1,1,1,1}, {1, 1}, {0, 1, 0}}, // 17
    {{-1, 1, -1},  {1,1,1,1},  {0, 1}, {0, 1, 0}}, // 18
    
    {{-1, 1, -1},  {1,1,1,1},  {0, 1}, {0, 1, 0}}, // 18
    {{-1, 1, 1},  {1,1,1,1}, {0, 0}, {0, 1, 0}}, // 19
    {{1, 1, 1},  {1,1,1,1}, {1, 0}, {0, 1, 0}}, // 16
};

const GLubyte Indices4[] = {
    0, 1, 2,
    2, 3, 0
};

- (instancetype)initWithShader:(BaseEffect *)shader {
    
    if ((self = [super initWithName:"WestFace" shader:shader
                           vertices:(Vertex *)Vertices4
                        vertexCount:sizeof(Vertices4) / sizeof(Vertices4[0])])) {
        
        self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
        self.specularColor = GLKVector4Make(1, 1, 1, 1);
        self.shininess = 10;
        self.scale = 5;
        
        [self loadTexture:@"floor.jpg"];
    }
    return self;
}

@end

//
//  ViewController.m
//  Asn2
//
//  Created by Renz on 3/11/19.
//  Copyright © 2019 Renz. All rights reserved.
//

#import "ViewController.h"
#import "Cube.h"
#import "TestScene.h"
#import "Director.h"

@interface ViewController () {
    BaseEffect* _shader;
    GLKMatrix4 cameraViewMatrix;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    UIPinchGestureRecognizer *zoomInGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action: @selector(handleZoomInPinchGesture:)];
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:zoomInGesture];
    [self.view addGestureRecognizer:swipeLeftGesture];
    [self.view addGestureRecognizer:swipeRightGesture];
    [self.view addGestureRecognizer:doubleTapGesture];
    [self setupScene];
}

-(void)handleZoomInPinchGesture:(UIPinchGestureRecognizer *)sender {
    if (sender.scale > 1.0) {
        NSLog(@"%@ %@", @"> 1.0", @"Forward");
        cameraViewMatrix = GLKMatrix4Translate(cameraViewMatrix, 0, 0, 3.0f);
    } else {
        NSLog(@"%@ %@", @"< 1.0", @"Backward");
        cameraViewMatrix = GLKMatrix4Translate(cameraViewMatrix, 0, 0, -3.0f);
    }
}

-(void)handleSwipeLeftGesture:(UISwipeGestureRecognizer *) sender {
    NSLog(@"%@", @"Rotate Left");
    cameraViewMatrix = GLKMatrix4Rotate(cameraViewMatrix, GLKMathDegreesToRadians(90), 0, 1, 0);
}

-(void)handleSwipeRightGesture:(UISwipeGestureRecognizer *) sender {
    NSLog(@"%@", @"Rotate Right");
    cameraViewMatrix = GLKMatrix4Rotate(cameraViewMatrix, GLKMathDegreesToRadians(-90), 0, 1, 0);
}

-(void)handleDoubleTapGesture:(UITapGestureRecognizer *) sender {
    NSLog(@"%@", @"Reset Position");
    cameraViewMatrix = GLKMatrix4Identity;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);    /*
     float amount = 0.25 * sin(CACurrentMediaTime()) + 0.75;
     float amount2 = 0.25 * sin(CACurrentMediaTime()+M_PI_4) + 0.75;
     float amount3 = 0.25 * sin(CACurrentMediaTime()+M_PI_2) + 0.75;
     
     glClearColor(amount, amount2, amount3, 1.0);
     glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
     glEnable(GL_DEPTH_TEST);
     glEnable(GL_CULL_FACE);
     */
    [[Director sharedInstance].scene renderWithParentModelViewMatrix:cameraViewMatrix];
}

- (void) setupScene{
    _shader = [[BaseEffect alloc] init];
    _shader.transform.projectionMatrix = GLKMatrix4MakePerspective(GLKMathRadiansToDegrees(85.0), self.view.frame.size.width/self.view.frame.size.height, 1, 150);
    cameraViewMatrix = GLKMatrix4Identity;
    
    
    [Director sharedInstance].scene = [[TestScene alloc] initWithShader:_shader];
    [Director sharedInstance].view = self.view;
}

- (void)update {
    [[Director sharedInstance].scene updateWithDelta:self.timeSinceLastUpdate];
}

@end

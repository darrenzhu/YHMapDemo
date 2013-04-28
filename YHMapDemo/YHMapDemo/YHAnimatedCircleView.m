/*
 Copyright 2012 Yick-Hong Lam
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <QuartzCore/QuartzCore.h>
#import "YHAnimatedCircleView.h"

#define MAX_RATIO 1.0
#define MIN_RATIO 0.9

#define ANIMATION_DURATION 1.2

//repeat forever
#define ANIMATION_REPEAT HUGE_VALF

@implementation YHAnimatedCircleView {
    CAShapeLayer *circleLayer;
}

-(id)initWithCircle:(MKCircle *)circle
{
    self = [super initWithCircle:circle];
    
    if (self) {
        
        [self removeExistingAnimation];
        
        explorationRadiusView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        
        circleLayer = [CAShapeLayer layer];
        
        // Configure the apperence of the circle
        circleLayer.fillColor = [UIColor blueColor].CGColor;
        circleLayer.strokeColor = [UIColor blackColor].CGColor;
        circleLayer.lineWidth = 50;
        
        [explorationRadiusView.layer addSublayer:circleLayer];
        
        [self addSubview:explorationRadiusView];
        
        [self start];
    }
    
    return self;
}

- (void)dealloc
{
    [self removeExistingAnimation];
}

- (void)start
{
    //opacity animation setup
    CABasicAnimation *opacityAnimation;
    
    opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = ANIMATION_DURATION;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.15];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    //resize animation setup
    CABasicAnimation *transformAnimation;
    
    transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    
    transformAnimation.duration = ANIMATION_DURATION;
    transformAnimation.fromValue = [NSNumber numberWithFloat:MIN_RATIO];
    transformAnimation.toValue = [NSNumber numberWithFloat:MAX_RATIO];
    
    //group the two animation
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.repeatCount = ANIMATION_REPEAT;
    group.duration = ANIMATION_DURATION * 1.5;
    [group setAnimations:[NSArray arrayWithObjects:opacityAnimation, transformAnimation, nil]];
    
    
    //apply the grouped animaton
    [explorationRadiusView.layer addAnimation:group forKey:@"groupAnimation"];
}

- (void)stop
{
    [self removeExistingAnimation];
}

- (void)removeExistingAnimation
{
    if (explorationRadiusView) {
        [explorationRadiusView.layer removeAllAnimations];
        [explorationRadiusView removeFromSuperview];
        explorationRadiusView = nil;
    }
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)ctx
{
    //the circle center
    MKMapPoint mpoint = MKMapPointForCoordinate([[self overlay] coordinate]);
    
    //geting the radius in map point
    double radius = [(MKCircle*)[self overlay] radius];
    double mapRadius = radius * MKMapPointsPerMeterAtLatitude([[self overlay] coordinate].latitude);
    
    //calculate the rect in map coordination
    MKMapRect mrect = MKMapRectMake(mpoint.x - mapRadius, mpoint.y - mapRadius, mapRadius * 2, mapRadius * 2);
    
    //get the rect in pixel coordination and set to the imageView
    CGRect rect = [self rectForMapRect:mrect];
    
    if (explorationRadiusView) {
        explorationRadiusView.frame = rect;
        //explorationRadiusView.layer.cornerRadius = rect.size.width / 2;
        
        // Set up the shape of the circle
        int radius = rect.size.width / 2;
        
        // Make a circular shape
        circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                      cornerRadius:radius].CGPath;
        // Center the shape in self.view
        circleLayer.position = CGPointMake(CGRectGetMidX(rect)-radius,
                                           CGRectGetMidY(rect)-radius);
    }
}

@end

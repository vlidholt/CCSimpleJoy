//
//  CCSimpleJoy.m
//  HackTest
//
//  Created by Viktor on 10/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSimpleJoy.h"

#define PADDING_H 80

@interface CCSimpleJoySprite : CCSprite
{
    CGPoint _dragStart;
    CGPoint _joyStart;
}
@end

@interface CCSimpleJoy (Private)

- (void) setTarget:(CGPoint)target;

@end

@implementation CCSimpleJoySprite

- (id) init
{
    self = [super initWithImageNamed:@"touch.png"];
    if (!self) return NULL;
    
    self.userInteractionEnabled = YES;
    self.hitAreaExpansion = 50;
    
    return self;
}

- (void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self stopAllActions];
    [self runAction:[CCActionFadeOut actionWithDuration:2]];
    
    _dragStart = [touch locationInNode:self.parent];
    _joyStart = self.position;
}

- (void) touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self stopAllActions];
    [self runAction:[CCActionFadeIn actionWithDuration:1]];
}

- (void) touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint delta = ccpSub([touch locationInNode:self.parent], _dragStart);
    
    CGPoint newPosition = ccpAdd(_joyStart, delta);
    
    CGSize screenSize = self.parent.contentSizeInPoints;
    
    // Check bounds
    if (newPosition.x < PADDING_H) newPosition.x = PADDING_H;
    if (newPosition.x > screenSize.width - PADDING_H) newPosition.x = screenSize.width - PADDING_H;
    
    if (newPosition.y < PADDING_H) newPosition.y = PADDING_H;
    if (newPosition.y > screenSize.width - PADDING_H) newPosition.y = screenSize.width - PADDING_H;
    
    self.position = newPosition;
    
    float xTarget = (newPosition.x - PADDING_H) / (screenSize.width - PADDING_H * 2);
    float yTarget = (newPosition.y - PADDING_H) / (screenSize.width - PADDING_H * 2);
    
    CCSimpleJoy* joy = (CCSimpleJoy*)self.parent;
    
    [joy setTarget: ccp(xTarget, yTarget)];
}

@end


@implementation CCSimpleJoy

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    
    self.contentSizeType = CCSizeTypeNormalized;
    self.contentSize = CGSizeMake(1, 1);
    
    _handle = [[CCSimpleJoySprite alloc] init];
    [self addChild:_handle];
    
    return self;
}

- (void) onEnter
{
    _handle.position = ccp(self.contentSizeInPoints.width/2, 50);
    
    [super onEnter];
}

- (void) setTarget:(CGPoint)target
{
    _target = target;
}

@end

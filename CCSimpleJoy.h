//
//  CCSimpleJoy.h
//  HackTest
//
//  Created by Viktor on 10/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@class CCSimpleJoySprite;

@interface CCSimpleJoy : CCNode
{
    CCSimpleJoySprite* _handle;
}

@property (nonatomic,readonly) CGPoint target;

@end

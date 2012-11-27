//
//  LUMorseContants.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/20/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUMorseContants.h"

static CGFloat basicSignalTime = 0.4f;

@implementation LUMorseContants

+(CGFloat)getDotSignalTime {
    return basicSignalTime;
}

+(CGFloat)getStreakSignalTime {
    return basicSignalTime * 3;
}

+(CGFloat)getCharacterSeparationSignalTime {
    return basicSignalTime * 3;
}

+(CGFloat)getSignalLightSpaceInterval {
    return basicSignalTime;
}

+(CGFloat)getSignalNonLightSpaceInterval {
    return 0.0f;
}

@end

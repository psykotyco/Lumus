//
//  LUMorseContants.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/20/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LUMorseContants : NSObject

+(CGFloat)getDotSignalTime;

+(CGFloat)getStreakSignalTime;

+(CGFloat)getCharacterSeparationSignalTime;

+(CGFloat)getSignalLightSpaceInterval;

+(CGFloat)getSignalNonLightSpaceInterval;

@end

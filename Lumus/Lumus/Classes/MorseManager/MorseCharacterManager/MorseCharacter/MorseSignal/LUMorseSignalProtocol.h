//
//  LUMorseSignalProtocol.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LUMorseSignalDelegate.h"

@protocol LUMorseSignalProtocol <NSObject>

@property (nonatomic,strong) id<LUMorseSignalDelegate> delegate;

-(void)showLightSignal;

-(void)showNonLighSignal;

@end

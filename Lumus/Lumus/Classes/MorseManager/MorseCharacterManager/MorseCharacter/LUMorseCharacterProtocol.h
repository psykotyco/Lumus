//
//  LUMorseCharacterProtocol.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUMorseCharacterDelegate.h"

@protocol LUMorseCharacterProtocol <NSObject>

@property (nonatomic,strong) id<LUMorseCharacterDelegate>delegate;

-(void)showCharacterSignal;

-(NSString *)getCharacterRepresented;

-(NSArray *)getMorseCharacterRepresentation;

@end

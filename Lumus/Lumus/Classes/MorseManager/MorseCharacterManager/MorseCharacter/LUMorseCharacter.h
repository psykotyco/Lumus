//
//  LUMorseCharacter.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LUMorseCharacterProtocol.h"

#import "LUMorseSignalDelegate.h"

@interface LUMorseCharacter : NSObject <LUMorseCharacterProtocol,LUMorseSignalDelegate>

-(void)loadMorseCharacter:(NSString *)character;

-(void)loadMorseCharacterSeparator;

-(void)loadMorseEndWord;

@end

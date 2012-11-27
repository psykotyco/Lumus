//
//  LUMorseCharacterManager.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/19/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LUMorseCharacter.h"

@interface LUMorseCharacterManager : NSObject

-(NSString *)getValidCharacters;

-(id<LUMorseCharacterProtocol>)getMorseCharacterForCharacter:(NSString *)character;

-(id<LUMorseCharacterProtocol>)getMorseCharacterSeparator;

-(id<LUMorseCharacterProtocol>)getMorseCharacterForFinishWord;

@end

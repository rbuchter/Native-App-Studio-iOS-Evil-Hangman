//
//  GameEngineController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngineController : NSObject

- (BOOL) inputSizeCheck: (NSString *) input;
- (BOOL) inputFormatCheck: (NSString *) input;
- (BOOL) inputLettersArrayCheck: (NSString *) input;


- (void) lettersUpdate: (NSString *) input;
- (void) wordUpdate: (NSString *) input;

- (void) newGame;

- (NSString *) newLettersString;
- (NSString *) newWordString;
- (NSString *) newLivesString;

- (BOOL) livesCheck;

@end

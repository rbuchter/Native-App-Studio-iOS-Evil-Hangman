//
//  GameEngineController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngineController : NSObject

// Public game functions
- (void) mainGame: (NSString *) input;
- (void) newGame;
- (BOOL) winCheck;
- (BOOL) loseCheck; 

// Public input check functions
- (BOOL) inputSizeCheck: (NSString *) input;
- (BOOL) inputFormatCheck: (NSString *) input;
- (BOOL) inputLettersArrayCheck: (NSString *) input;

// Public letters, word and lives functions
- (NSString *) newLettersString;
- (NSString *) newWordString;
- (NSString *) newLivesString;

@end

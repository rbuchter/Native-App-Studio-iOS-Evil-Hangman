//
//  GameEngineController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngineController : NSObject

// Game functions
- (void) mainGame: (NSString *) input;
- (void) newGame;
- (NSInteger) winCheck;

// Check input functions
- (BOOL) inputSizeCheck: (NSString *) input;
- (BOOL) inputFormatCheck: (NSString *) input;
- (BOOL) inputLettersArrayCheck: (NSString *) input;

// Letters, word and lives functions
- (NSString *) newLettersString;
- (NSString *) newWordString;
- (NSString *) newLivesString;

@end

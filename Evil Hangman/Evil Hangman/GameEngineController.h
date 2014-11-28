//
//  GameEngineController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngineController : NSObject

- (void)loadWords; 

- (BOOL)inputSizeCheck: (NSString *) input;
- (BOOL)inputFormatCheck: (NSString *) input;
- (BOOL) inputLettersArrayCheck: (NSString *) input;

- (void)lettersUpdate: (NSString *) input;
- (void)wordUpdate;

- (NSArray *)newLettersArray;
- (NSString *)newLettersString;

- (NSArray *)newWordArray;
- (NSString *)newWordString;

- (NSInteger *)newLivesInteger;
- (NSString *)newLivesString;
- (void)livesUpdate;

@end

//
//  GameEngineController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameEngineController.h"

@implementation GameEngineController

- (void)textPrint {
    NSLog(@"Hello, World!");
}


- (NSString*)GenerateGuessedLetterState {
    // Create string based on array with letters
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *guessedLettersState = @"";
    NSString *letter;
    for (letter in [defaults objectForKey:@"currentGuessedLettersState"]){
        guessedLettersState = [guessedLettersState stringByAppendingFormat:@"%@ ", letter];
    }
    return guessedLettersState;
}

- (NSString*)GenerateGuessState {
    // Create string based on array with letters
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *guessState = @"";
    NSString *letter;
    for (letter in [defaults objectForKey:@"currentGuessState"]){
        guessState = [guessState stringByAppendingFormat:@"%@ ", letter];
    }
    return guessState;
}

- (NSMutableArray*)NewGuessState {
    // Creates a string with placeholders '_' for the letters of the word to guess
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *guessState;
    for (int i = 1; i <= (long)[defaults integerForKey:@"numberOfLetters"]; i++)
    {
        [guessState addObject: @"_"];
    }
    [guessState addObject: nil];
    return guessState;
}



@end



//
//  GameEngineController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameEngineController.h"

@implementation GameEngineController

// Checks if input is 1 character
- (BOOL)inputSizeCheck: (NSString *) input {

    // Length of input
    NSInteger length = [input length];

    if (length == 1){
        return TRUE;
    }

    else {
        return FALSE;
    }
}

// Checks if input only contain alphabetical characters
- (BOOL)inputFormatCheck: (NSString *) input {
    
    // Uppercase charactersets
    NSCharacterSet *uppercaseLetterSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    if ([[input stringByTrimmingCharactersInSet:uppercaseLetterSet] isEqualToString: @""]) {
        return TRUE;
    }
    
    else {
        return FALSE;
    }
}

// Checks if input is still in LettersArray
- (BOOL) inputLettersArrayCheck: (NSString *) input {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *lettersArray;
    lettersArray = [defaults objectForKey:@"currentLettersState"];
    
    if ([lettersArray containsObject: input]) {
        NSLog(@"CORRECT GUESS");
        return TRUE;
    }
    
    else {
        NSLog(@"INCORRECT GUESS");
        return FALSE;
    }
}

// Removes guessed letter form array
- (void)lettersUpdate: (NSString *) input {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *lettersArray;
    lettersArray = [[defaults objectForKey:@"currentLettersState"]mutableCopy];
    
    // remove letter input
    [lettersArray removeObject: input];
    
    [defaults setObject: lettersArray forKey:@"currentLettersState"];
}

//
- (void)wordUpdate {
    
}

// Create new array with A-Z letters
- (NSArray *)newLettersArray{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *lettersArray;
    lettersArray = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    // Set value of letters array in UserDefaults
    [defaults setObject: lettersArray forKey:@"currentLettersState"];
    return lettersArray;
}

// Creates string of letters in currentLettersState in UserDefaults
- (NSString *)newLettersString{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lettersString = @"";
    NSString *letter;
    
    for (letter in [defaults objectForKey:@"currentLettersState"]){
        lettersString = [lettersString stringByAppendingFormat:@"%@ ", letter];
    }
    
    NSLog(@"%@", lettersString);
    return lettersString;
}


// Create a array for the word to guess based on number of letters from the UserDefaults
- (NSArray *)newWordArray {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *wordArray;
    wordArray = [NSMutableArray arrayWithObjects: nil];
    
    for (int i = 1; i <= (long)[defaults integerForKey:@"numberOfLetters"]; i++)
    {
        [wordArray addObject: @"_"];
    }
    
    // Set value of word array in UserDefaults
    [defaults setObject:wordArray forKey:@"currentWordState"];
    return wordArray;
}

// Creates string of word in currentWordState in UserDefaults
- (NSString *)newWordString{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *wordString = @"";
    NSString *letter;
    
    for (letter in [defaults objectForKey:@"currentWordState"]){
        wordString = [wordString stringByAppendingFormat:@"%@ ", letter];
    }
    
    NSLog(@"%@", wordString);
    return wordString;
}

// Creates string of currentLives in UserDefaults
- (NSString *)newLivesString {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger *lives;
    
    // Gets number of lives from UserDefaults
    lives = [defaults integerForKey:@"numberOfIncorrectGuesses"];
    
    // Save currentlives to UserDefaults
    [defaults setInteger: lives forKey:@"currentlives"];
    
    return [NSString stringWithFormat:@"%i", lives];
}

@end



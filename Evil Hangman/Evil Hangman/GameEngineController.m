//
//  GameEngineController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameEngineController.h"

@implementation GameEngineController

- (void)loadWords {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // Creates array of full plist file
    NSMutableArray *wordsArray = [[NSMutableArray alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
    NSString *word;
    NSMutableArray *currentWordsArray = [[NSMutableArray alloc]init];
    
    NSInteger wordLength = [defaults integerForKey:@"numberOfLetters"];
          
    // Load words
    for (word in wordsArray)
        if([word length] == wordLength)
        {
            [currentWordsArray addObject: [NSString stringWithFormat:@"%@", word]];
        }
    
    // Save word list in UserDefaults
    [defaults setObject: currentWordsArray forKey:@"currentWordArray"];
}

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
    
    NSMutableArray *lettersArray = [defaults objectForKey:@"currentLettersState"];
    
    if ([lettersArray containsObject: input]) {
        return TRUE;
    }
    
    else {
        return FALSE;
    }
}

// Removes guessed letter form array
- (void)lettersUpdate: (NSString *) input {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *lettersArray = [[defaults objectForKey:@"currentLettersState"]mutableCopy];
    
    // remove letter input
    [lettersArray removeObject: input];
    
    // Update UserDefaults
    [defaults setObject: lettersArray forKey:@"currentLettersState"];
}

//
- (void)wordUpdate {
    
}

- (void)livesUpdate {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Gets number of lives from UserDefaults and remove 1 live
    NSInteger lives = [defaults integerForKey:@"currentLives"] - 1;
    
    // Save currentLives to UserDefaults
    [defaults setInteger: lives forKey:@"currentLives"];
}

// Create new array with A-Z letters
- (NSArray *)newLettersArray{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *lettersArray = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
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
    
    return lettersString;
}


// Create a array for the word to guess based on number of letters from the UserDefaults
- (NSArray *)newWordArray {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *wordArray = [[NSMutableArray alloc]init];
    
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
    
    return wordString;
}

//
- (NSInteger *)newLivesInteger {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger livesInteger = [defaults integerForKey:@"numberOfIncorrectGuesses"];
    
    [defaults setInteger:livesInteger forKey:@"currentLives"];
    
    return (int *)livesInteger;
}

// Creates string of currentLives in UserDefaults
- (NSString *)newLivesString {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [NSString stringWithFormat:@"%ld", (long)[defaults integerForKey:@"currentLives"]];
}

@end



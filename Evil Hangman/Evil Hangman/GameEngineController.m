//
//  GameEngineController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameEngineController.h"

@implementation GameEngineController {
    
    NSUserDefaults *defaults; 
}

// Checks if user has lose game
- (BOOL) livesCheck {
    
    defaults = [ NSUserDefaults standardUserDefaults ];

    NSInteger lives = [ defaults integerForKey: @"currentLives" ];
    
    if (lives > 1)
        return TRUE;
    else
        return FALSE;
    
}





// Loads words.plist into array and extract array with words of right size
- (void) wordsListLoad {
    
    defaults = [ NSUserDefaults standardUserDefaults ];

    // Creates wordsArray of all words in file words.plist
    NSMutableArray *wordsArray = [[ NSMutableArray alloc ] initWithContentsOfFile: [[ NSBundle mainBundle ] pathForResource: @"words" ofType: @"plist" ]];
    
    NSString *word;
    NSInteger wordLength = [ defaults integerForKey: @"numberOfLetters" ];
    NSMutableArray *currentWordsArray = [[ NSMutableArray alloc ] init ];
    
    // Loops trough wordsArray and add words of right size to currentWordsArray
    for (word in wordsArray)
        if([ word length ] == wordLength)
            [ currentWordsArray addObject: [ NSString stringWithFormat: @"%@", word ]];
    
    [ defaults setObject: currentWordsArray forKey: @"currentWordArray" ];
    
}





// Checks if input is the right size of 1 character
- (BOOL) inputSizeCheck: ( NSString * ) input {

    NSInteger length = [ input length ];

    if (length == 1)
        return TRUE;
    else
        return FALSE;
    
}

// Checks if input only contains alphabetical characters (A-Z)
- (BOOL)inputFormatCheck: ( NSString * ) input {
    
    NSCharacterSet *uppercaseLetterSet = [ NSCharacterSet characterSetWithCharactersInString: @"ABCDEFGHIJKLMNOPQRSTUVWXYZ" ];
    
    if ([[ input stringByTrimmingCharactersInSet: uppercaseLetterSet ] isEqualToString: @"" ])
        return TRUE;
    else
        return FALSE;
    
}

// Checks if input is in array 'currentLettersState' in UserDefaults
- (BOOL) inputLettersArrayCheck: ( NSString * ) input {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSMutableArray *lettersArray = [ defaults objectForKey: @"currentLettersState" ];
    
    if ([ lettersArray containsObject: input ])
        return TRUE;
    else
        return FALSE;
    
}

// Updates 'currentLettersState' in UserDefaults by removing guessed letter form array
- (void) lettersUpdate: (NSString *) input {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSMutableArray *lettersArray = [[ defaults objectForKey: @"currentLettersState" ] mutableCopy ];

    [ lettersArray removeObject: input ];
    
    [ defaults setObject: lettersArray forKey: @"currentLettersState" ];
    
}





//
- (void)wordUpdate: (NSString *) input {
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *currentWordArray = [defaults objectForKey: @"currentWordArray" ];
    NSString *word;
    NSMutableDictionary *wordDictionary = [NSMutableDictionary dictionary];
    
    for (word in currentWordArray)
    {
        NSString *key = @"";
        NSMutableArray *wordArray;
        
        // Loops through characters word
        for (NSInteger charIndex=0; charIndex<word.length; charIndex++)
        {
            
            NSString *character = [NSString stringWithFormat:@"%C",[word characterAtIndex:charIndex]];
            
            if([character isEqualToString: input])
                key = [key stringByAppendingFormat:@"%@", character];
            else
                key = [key stringByAppendingFormat:@"_"];

        }
        
        // Add values to dictionary
        if ([[wordDictionary valueForKey:key] count] == 0)
            wordArray = [[NSMutableArray alloc]init];
        else
            wordArray = [wordDictionary valueForKey:key];
        
        [wordArray addObject: word];
        [wordDictionary setObject: wordArray forKey: key];
        
    }
    
    NSString *keyDictionary;
    int sizeMaxWordArray = 0;
    NSString *keyMaxWordArray;
    
    // Loop through dictionary
    for (keyDictionary in wordDictionary)
    {
        int sizeArray = 0;
        
        // Count number of words in array
        for(word in [wordDictionary objectForKey: keyDictionary])
        {
            sizeArray += 1;
        }
        
        // Change value if size of wordArray is bigger than current one
        if (sizeMaxWordArray < sizeArray) {
            sizeMaxWordArray = sizeArray;
            keyMaxWordArray = keyDictionary;
        }
    }
    NSLog(@"%d", sizeMaxWordArray);
    NSLog(@"%@", keyMaxWordArray);
    
    
    // Update UserDefaults
    [ defaults setObject: [ wordDictionary objectForKey: keyMaxWordArray ] forKey: @"currentWordArray" ];
    
    
    
    NSMutableArray *currentWord  = [[ defaults objectForKey: @"currentWordState" ] mutableCopy ];
    NSInteger *sizeWordSwap = 0;
    
    for (NSInteger charIndex = 0; charIndex < keyMaxWordArray.length; charIndex++)
    {
        NSString *character = [ NSString stringWithFormat: @"%C",[ keyMaxWordArray characterAtIndex: charIndex ]];
        
        if( ![ character isEqualToString: @"_" ])
        {
            [ currentWord replaceObjectAtIndex: charIndex withObject: character ];
            sizeWordSwap += 1;
        }
    }
    
    // Update lives based on number of character swaps.
    [ self wordSwapCheck: sizeWordSwap ];

    // Update word array
    [ defaults setObject: currentWord forKey: @"currentWordState" ];

}

// 
- (void) wordSwapCheck: ( NSInteger * ) sizeWordSwap {
    
    if (sizeWordSwap == 0)
        [ self livesUpdate ];
    
}

// Updates 'currentLives' in UserDefaults with lives decreased by 1
- (void) livesUpdate {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSInteger lives = [ defaults integerForKey: @"currentLives" ];
    
    if (lives > 0)
        lives -= 1;

    [ defaults setInteger: lives forKey: @"currentLives" ];

}

// Sets all UserDefaults to start new game based on settings
- (void) newGame {
    
    [ self newLettersArray ];
    [ self newWordArray ];
    [ self newLivesInteger ];
    
    [ self wordsListLoad ];
    
}

// Sets 'currentLettersState' to value of array with characters A-Z in UserDefauls
- (void) newLettersArray {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSMutableArray *lettersArray = [ NSMutableArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil ];
    
    // Set value of letters array in UserDefaults
    [ defaults setObject: lettersArray forKey: @"currentLettersState" ];

}

// Creates string of array of 'currentLettersState' in UserDefaults
- (NSString *) newLettersString {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSArray *lettersArray = [ defaults objectForKey: @"currentLettersState" ];
    NSString *letter;
    NSString *lettersString = @"";
    
    for (letter in lettersArray)
        lettersString = [ lettersString stringByAppendingFormat: @"%@ ", letter];
    
    return lettersString;
    
}

/* 
Sets 'currentWordState' to array with placeholders '_' for the letters to be guessed,
based on 'numberOfLetters' in UserDefaults
 */
- (void) newWordArray {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSMutableArray *wordArray = [[ NSMutableArray alloc ] init ];
    int numLetters = [ defaults integerForKey: @"numberOfLetters" ];
    
    for (int i = 1; i <= numLetters; i++)
        [ wordArray addObject: @"_" ];
    
    [ defaults setObject: wordArray forKey: @"currentWordState" ];

}

// Creates string of word array in 'currentWordState' in UserDefaults
- (NSString *) newWordString {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    NSArray *wordArray = [ defaults objectForKey: @"currentWordState" ];
    NSString *letter;
    NSString *wordString = @"" ;
    
    for (letter in wordArray)
        wordString = [ wordString stringByAppendingFormat: @"%@ " , letter ];
    
    return wordString;
    
}

// Sets 'currentLives' to value of 'numberOfIncorrectGuesses' in UserDefauls
- (void) newLivesInteger {
    
    defaults = [ NSUserDefaults standardUserDefaults ];

    [ defaults setInteger: [ defaults integerForKey: @"numberOfIncorrectGuesses" ] forKey: @"currentLives" ];
    
}

// Creates string of 'currentLives' in UserDefaults
- (NSString *) newLivesString {
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    return [ NSString stringWithFormat: @"%ld", (long) [ defaults integerForKey: @"currentLives" ]];
    
}

@end



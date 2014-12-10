//
//  GameEngineController.m
//  Evil Hangman
//
//  Process all the input from the GameViewController and organize the gameplay
//
//  Created by Rick Buchter on 26-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameEngineController.h"

@implementation GameEngineController {
    
    NSUserDefaults *defaults;
}

// GAME FUNCTIONS
// Main game function, called on every new input
- (void) mainGame: (NSString *) input {
    
    // Removes input from letters
    [ self lettersUpdate: input ];
    
    // Generate dictionary
    NSMutableDictionary *wordDictionary = [ self wordDictionary: input ];
    
    // Search for key of main item in dictionary
    NSString *keyMainItemDictionary = [ self mainWordDictionary: wordDictionary ];
    
    // Update UserDefaults with biggest array
    [ defaults setObject: [ wordDictionary objectForKey: keyMainItemDictionary ] forKey: @"currentWordArray" ];
    
    // Updates word
    [ self wordUpdate: keyMainItemDictionary ];
    
}

// Sets all UserDefaults to start new game based on settings
- (void) newGame {
    
    [ self initUserDefaults ];
    
    [ self newLettersArray ];
    [ self newWordArray ];
    [ self newLivesInteger ];
    
    [ self wordsListLoad ];
    
}

- (void) initUserDefaults {
    defaults = [ NSUserDefaults standardUserDefaults ];
}

// Checks if user has win game
- (BOOL) winCheck {
    
    NSMutableArray *currentWord  = [ defaults objectForKey: @"currentWordState" ];
    NSString *character;
    NSInteger *count = 0;
    
    for ( character in currentWord ) {
        if ( [character isEqual: @"_" ] )
            count += 1;
    }
    
    NSInteger lives = [ defaults integerForKey: @"currentLives" ];
    
    // Won game
    if (count == 0 && lives >= 1)
        return TRUE;
    else
        return FALSE;
    
}

// Check if user has lose the game
- (BOOL) loseCheck {
    
    NSInteger lives = [ defaults integerForKey: @"currentLives" ];
    
    if ( lives >= 1 )
        return FALSE;
    else
        return TRUE;
    
}


// INPUT CHECK FUNCTIONS
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
    
    NSMutableArray *lettersArray = [ defaults objectForKey: @"currentLettersState" ];
    
    if ([ lettersArray containsObject: input ])
        return TRUE;
    else
        return FALSE;
    
}


// DICTIONARY FUNCTIONS
// Loads words.plist into array and extract array with words of right size
- (void) wordsListLoad {
    
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

// Function generate key for dictionary of word, based on input
- (NSString *) keyWordDictionary: (NSString *) input :(NSString *) word {
    
    NSString *key = @"" ;
    
    // Loops through characters of word and creates key for word
    for ( NSInteger charIndex = 0; charIndex < word.length; charIndex++ )
    {
        NSString *character = [ NSString stringWithFormat: @"%C",[ word characterAtIndex: charIndex ]];
        
        if([ character isEqualToString: input ])
            key = [ key stringByAppendingFormat: @"%@", character ];
        else
            key = [ key stringByAppendingFormat: @"_" ];
        
    }
    
    return key;
    
}

// Fucntion generate dictionary with keys based on input and values as word arrays
- (NSMutableDictionary *)wordDictionary: (NSString *) input {
    
    NSMutableArray *currentWordArray = [ defaults objectForKey: @"currentWordArray" ];
    NSString *word;
    NSMutableDictionary *wordDictionary = [ NSMutableDictionary dictionary ];
    
    for (word in currentWordArray)
    {
        NSString * key = [self keyWordDictionary: input :word];
        
        NSMutableArray *wordArray;
        
        // Checks if there's already a array in dictionary
        if ([[ wordDictionary valueForKey: key ] count ] == 0 )
            wordArray = [[ NSMutableArray alloc ] init ];
        else
            wordArray = [ wordDictionary valueForKey: key ];
        
        // Add words to array in dictionary
        [ wordArray addObject: word ];
        [ wordDictionary setObject: wordArray forKey: key ];
        
    }
    
    return wordDictionary;
    
}

// Function search for biggest opbject in dictionary
- (NSString *) mainWordDictionary: (NSMutableDictionary *) dictionary {
    
    NSString *key;
    NSString *word;
    
    int sizeMainItemDictionary = 0;
    NSString *keyMainItemDictionary;
    
    // Loop through dictionary
    for (key in dictionary)
    {
        int sizeArray = 0;
        
        // Count number of words in array
        for(word in [dictionary objectForKey: key])
        {
            sizeArray += 1;
        }
        
        // Change value if size of wordArray is bigger than current one
        if (sizeMainItemDictionary < sizeArray) {
            sizeMainItemDictionary = sizeArray;
            keyMainItemDictionary = key;
        }
    }
    
    return keyMainItemDictionary;
    
}


// LETTERS FUNCTIONS
// Sets 'currentLettersState' to value of array with characters A-Z in UserDefauls
- (void) newLettersArray {
    
    NSMutableArray *lettersArray = [ NSMutableArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil ];
    
    // Set value of letters array in UserDefaults
    [ defaults setObject: lettersArray forKey: @"currentLettersState" ];
    NSLog(@"Game:NewLettersArray:ObjectForKey:CurrentLettersState:%@", [ defaults objectForKey: @"currentLettersState" ]);

}

// Creates string of array of 'currentLettersState' in UserDefaults
- (NSString *) newLettersString {
    
    //defaults = [ NSUserDefaults standardUserDefaults ];
    NSLog(@"Game:NewLettersString:ObjectForKey:CurrentLettersState:%@", [ defaults objectForKey: @"currentLettersState" ]);
    
    NSArray *lettersArray = [ defaults objectForKey: @"currentLettersState" ];
    NSString *letter;
    NSString *lettersString = @"";
    
    for (letter in lettersArray)
        lettersString = [ lettersString stringByAppendingFormat: @"%@ ", letter];
    
    return lettersString;
    
}

// Updates 'currentLettersState' in UserDefaults by removing guessed letter form array
- (void) lettersUpdate: (NSString *) input {
    
    NSMutableArray *lettersArray = [[ defaults objectForKey: @"currentLettersState" ] mutableCopy ];
    
    [ lettersArray removeObject: input ];
    
    [ defaults setObject: lettersArray forKey: @"currentLettersState" ];
    
}


// WORD FUNCTIONS
/* Sets 'currentWordState' to array with placeholders '_' for the letters to be guessed,
based on 'numberOfLetters' in UserDefaults */
- (void) newWordArray {
    
    NSMutableArray *wordArray = [[ NSMutableArray alloc ] init ];
    int numLetters = [ defaults integerForKey: @"numberOfLetters" ];
    
    for (int i = 1; i <= numLetters; i++)
        [ wordArray addObject: @"_" ];
    
    [ defaults setObject: wordArray forKey: @"currentWordState" ];

}

// Creates string of word array in 'currentWordState' in UserDefaults
- (NSString *) newWordString {
    
    NSArray *wordArray = [ defaults objectForKey: @"currentWordState" ];
    NSString *letter;
    NSString *wordString = @"" ;
    
    for (letter in wordArray)
        wordString = [ wordString stringByAppendingFormat: @"%@ " , letter ];
    
    return wordString;
    
}

// Updates 'currentWordState' in UserDefaults based on the largest key in dictionary.
- (void) wordUpdate: (NSString *) keyMainItemDictionary {
    
    NSMutableArray *currentWord  = [[ defaults objectForKey: @"currentWordState" ] mutableCopy ];
    NSInteger *sizeWordSwap = 0;
    
    for (NSInteger charIndex = 0; charIndex < keyMainItemDictionary.length; charIndex++){
        
        NSString *character = [ NSString stringWithFormat: @"%C",[ keyMainItemDictionary characterAtIndex: charIndex ]];
        
        if( ![ character isEqualToString: @"_" ]) {
            [ currentWord replaceObjectAtIndex: charIndex withObject: character ];
            sizeWordSwap += 1;
        }
    }
    
    [ self livesUpdate: sizeWordSwap ];
    
    [ defaults setObject: currentWord forKey: @"currentWordState" ];
    
}


// LIVES FUNCTIONS
// Sets 'currentLives' to value of 'numberOfIncorrectGuesses' in UserDefauls
- (void) newLivesInteger {

    [ defaults setInteger: [ defaults integerForKey: @"numberOfIncorrectGuesses" ] forKey: @"currentLives" ];
    
}

// Creates string of 'currentLives' in UserDefaults
- (NSString *) newLivesString {
    
    return [ NSString stringWithFormat: @"%ld", (long) [ defaults integerForKey: @"currentLives" ]];
    
}

// Updates 'currentLives' in UserDefaults with lives decreased by 1
- (void) livesUpdate: (NSInteger *) sizeWordSwap {
    
    if ( sizeWordSwap == 0 ) {
    
        NSInteger lives = [ defaults integerForKey: @"currentLives" ];
    
        if (lives > 0)
            lives -= 1;
    
        [ defaults setInteger: lives forKey: @"currentLives" ];
    }
}

@end



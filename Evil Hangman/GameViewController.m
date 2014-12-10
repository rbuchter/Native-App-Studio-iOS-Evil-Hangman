//
//  GameViewController.m
//  Evil Hangman
//
//  Displays the current state of the game and process the input to GameEngineController
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameViewController.h"
#import "GameEngineController.h"

@interface GameViewController () {
    
    NSUserDefaults *defaults;
    GameEngineController *game;
    
}

@end

@implementation GameViewController
@synthesize letterInput;

- (void) viewDidLoad {
    [ super viewDidLoad ];
    
    NSLog(@"viewDidLoad:Game");

    
    defaults = [ NSUserDefaults standardUserDefaults ];
    game = [[ GameEngineController alloc ] init ];
    NSLog(@"IntegerValueFor NumberOfLetters%ld", (long)[ defaults integerForKey: @"numberOfLetters" ]);
    
    // Checks if any UserDefaults are set
    if ([ defaults integerForKey: @"numberOfLetters" ] == 0 ){
        [ defaults setInteger:5 forKey: @"numberOfLetters" ];
        [ defaults setInteger:7 forKey: @"numberOfIncorrectGuesses" ];
        NSLog(@"IntegerValueFor NumberOfLetters2%ld", (long)[ defaults integerForKey: @"numberOfLetters" ]);
        
        // Call to main game function
        [ game newGame ];
        
        [ defaults synchronize ];
    }
    
    // Updates all labels
    [ game initUserDefaults ];
    [self updateLabels];
 
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Start new game with variable form UserDefaults
- (IBAction) newGame: (UIButton *) sender {
    
    // Call to main game function
    [ game newGame ];
    
    // Updates all labels
    [ self updateLabels ];
    
}

// Removes keyboard if touched outside keyboard
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    
    [self.letterInput resignFirstResponder];
    
}

// Remove keyboard and process input
- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    
    [ textField resignFirstResponder ];
    
    // Sets input to uppercase
    NSString *input = [self.letterInput.text uppercaseString];
    
    // Process alphabetical input with 1 character, witch isn't inputted already
    if ([ game inputSizeCheck: input ] && [ game inputFormatCheck: input ] && [ game inputLettersArrayCheck: input ]){
            
        // Main game function
        [game mainGame: input];
            
        // Update labels
        [ self updateLabels];
        
    }
    else {
        
        // Alerts input
        [ self inputAlerts: (NSString *) input ];
        
    }
    
    // Alerts win
    [ self loseAlerts ];
    [ self winAlerts ];
    
    return NO;
    
}

// Function handles all input alerts
- (void) inputAlerts: (NSString *) input {
    
    // Shows alert if input is not the right size of characters
    if ( ![ game inputSizeCheck: input ] ) {
        UIAlertView *alert = [[ UIAlertView alloc ]
                              initWithTitle: @"Too large input"
                              message: @"It's not allowed to input more than one letter a time"
                              delegate: self
                              cancelButtonTitle: @"Continu game!"
                              otherButtonTitles: nil ];
        [alert show];
        [ self updateLabels ];
    }
    
    // Shows alert if input is not the correct format
    else if (![ game inputFormatCheck: input]) {
        UIAlertView *alert = [[ UIAlertView alloc ]
                              initWithTitle: @"Non alphabetical input"
                              message: @"It's not allowed to input other than basic alphabetical characters"
                              delegate: self
                              cancelButtonTitle: @"Continu game!"
                              otherButtonTitles: nil ];
        [alert show];
        self.letterInput.text = @"";
    }
    
    // Shows alert if input is already guessed
    else if ( ![ game inputLettersArrayCheck: input ] ) {
        UIAlertView *alert = [[ UIAlertView alloc ]
                              initWithTitle: @"Already guessed input"
                              message: @"This letter is already guessed, try another one"
                              delegate: self
                              cancelButtonTitle: @"Continu game!"
                              otherButtonTitles: nil ];
        [ alert show ];
        self.letterInput.text = @"";
        
    }
}


// Function handles win alert
- (void) winAlerts {
    
    if ( [ game winCheck ] ) {
        NSString *message = [NSString stringWithFormat: @"With %@ lives left! Not bad.", [ game newLivesString ]];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"You won!"
                              message: message
                              delegate:self
                              cancelButtonTitle: @"Cancel"
                              otherButtonTitles: @"Start new game!", nil ];
        [ alert show ];
        [ self updateLabels ];

    }
}

// Function handles lose alert
- (void) loseAlerts {
    
    if ( [ game loseCheck ]) {
        UIAlertView *alert = [[ UIAlertView alloc ]
                              initWithTitle: @"You lose!"
                              message: @"Some people make it.."
                              delegate:self
                              cancelButtonTitle: @"Cancel"
                              otherButtonTitles: @"Start new game!", nil];
        [ alert show ];
        [ self updateLabels ];
        
    }
}

// Add function for new game to alert views
- (void) alertView: (UIAlertView *) alertView didDismissWithButtonIndex: (NSInteger) buttonIndex {
    if (buttonIndex == 1) {
        
        [ game newGame ];
        [ self updateLabels ];
        
    }
}

// Function updates all labels
- (void) updateLabels {
    
    // Updates labels
    NSLog(@"IntegerValueFor NumberOfLetters:in UpdateLabels:%ld", (long)[ defaults integerForKey: @"numberOfLetters" ]);
    self.lettersLabel.text = [ game newLettersString ];
    NSLog(@"IntegerValueFor NumberOfLetters:in UpdateLabels:%@", [ game newLettersString ]);
    self.wordLabel.text = [ game newWordString ];
    self.livesLabel.text = [ game newLivesString ];
    
    // Empty input field
    self.letterInput.text = @"";
    
}

@end

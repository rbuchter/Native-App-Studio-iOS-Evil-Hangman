//
//  GameViewController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameViewController.h"
#import "GameEngineController.h"

@interface GameViewController () {
    
    NSUserDefaults *defaults;
    GameEngineController *Game;
    
}

@end

@implementation GameViewController
@synthesize letterInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    Game = [[GameEngineController alloc] init];
    
    // Checks if any UserDefaults are set
    if ([ defaults integerForKey: @"numberOfLetters" ] == 0 ){
        [ defaults setInteger:5 forKey: @"numberOfLetters" ];
        [ defaults setInteger:7 forKey: @"numberOfIncorrectGuesses" ];
        
        // Call to main game function
        [ Game newGame ];
        
        [ defaults synchronize ];
    }
    
    // Updates all labels
    [self updateLabels];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Start new game with variable form UserDefaults
- (IBAction)newGame:(UIButton *)sender {
    
    Game = [[GameEngineController alloc] init];
    
    // Call to main game function
    [ Game newGame ];
    
    // Updates all labels
    [ self updateLabels ];
    
}

// Removes keyboard if touched outside keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.letterInput resignFirstResponder];
}

// Remove keyboard and process input
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    Game = [[GameEngineController alloc] init];
    
    NSString *input = [self.letterInput.text uppercaseString];
    
    
    // Process alphabetical input with 1 character
    if ([Game inputSizeCheck:input] && [Game inputFormatCheck: input]){
        
        // Check if letter is already guessed
        if ([Game inputLettersArrayCheck:input]) {
            
            // Main game function
            [Game mainGame: input];
            
            // Update labels
            [self updateLabels];
        }
        
        else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Already guessed"
                                  message:@"This letter is already guessed, try another one"
                                  delegate:self
                                  cancelButtonTitle:@"Get it!"
                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    // Shows alert if input is not the right size of characters
    else if (![Game inputSizeCheck: input]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No valid input"
                              message:@"It's not allowed to input more than one letter a time"
                              delegate:self
                              cancelButtonTitle:@"Get it!"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Shows alert if input is not the correct format
    else if (![Game inputFormatCheck: input]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No alphabetical input"
                              message:@"It's not allowed to input other than basic alphabetical characters"
                              delegate:self
                              cancelButtonTitle:@"Get it!"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    
    switch ( [ Game winCheck ] ) {
            
            // Won game
        case 1: {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"You won!"
                                  message:@"Some people make it.."
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Start new game!",nil];
            [alert show];
            [self updateLabels];
            break;
        }
            // Lose game
        case -1: {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"You lose!"
                                  message:@"Some people make it.."
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Start new game!",nil];
            [alert show];
            [self updateLabels];
            break;
        }
            
        default:
            break;
    }
    
    return NO;
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        [Game newGame];
        [self updateLabels];
    }
}

// Function updates all labels
- (void) updateLabels {
    
    Game = [[GameEngineController alloc] init];
    
    // Updates labels
    self.lettersLabel.text = [Game newLettersString];
    self.wordLabel.text = [Game newWordString];
    self.livesLabel.text = [Game newLivesString];
    
    // Empty input field
    self.letterInput.text = @"";
}

@end

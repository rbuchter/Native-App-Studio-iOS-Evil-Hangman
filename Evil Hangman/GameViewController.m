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

//game instance = [[GameEngineController alloc] init];


- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    Game = [[GameEngineController alloc] init];
    
    // Checks if any userDefault are set
    if ([defaults integerForKey:@"numberOfLetters"] == 0){
        [defaults setInteger:5 forKey:@"numberOfLetters"];
        [defaults setInteger:7 forKey:@"numberOfIncorrectGuesses"];
        
        [Game newGame];
        [defaults synchronize];
    }
    
    // updates all labels
    [self updateLabels];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// start new game with variable form UserDefaults
- (IBAction)newGame:(UIButton *)sender {
    
    Game = [[GameEngineController alloc] init];
    
    // Create new array's in UserDefaults for the word and letters
    [Game newGame ];
    
    // updates all labels
    [self updateLabels];
    
}

//-(void)updateGuessLabel {
//    NSString *temp = new String;
//}


// Removes keyboard if touched outside keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.letterInput resignFirstResponder];
}

// Remove keyboard and process input
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    Game = [[GameEngineController alloc] init];
    
    if ([Game livesCheck]) {
        NSString *input;
        input = [self.letterInput.text uppercaseString];
        
        // Process alphabetical input with 1 character
        if ([Game inputSizeCheck:input] && [Game inputFormatCheck: input]){
            
            // Check if letter is already guessed
            if ([Game inputLettersArrayCheck:input]) {
                
                // Removes letter from array
                [Game wordUpdate:input];
                [Game lettersUpdate:input];
                
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
        else if (![Game inputSizeCheck:input]) {
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
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"You lose!"
                              message:@"Some people make it.."
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Start new game!",nil];
        [alert show];
        
        [self updateLabels];
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

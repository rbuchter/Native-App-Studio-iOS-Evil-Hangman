//
//  GameViewController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameViewController.h"
#import "GameEngineController.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize letterInput;

//game instance = [[GameEngineController alloc] init];


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    GameEngineController *currentGame = [[GameEngineController alloc] init];
    
    // Checks if any userDefault are set
    if ([defaults integerForKey:@"numberOfLetters"] == 0){
        [defaults setInteger:5 forKey:@"numberOfLetters"];
        [defaults setInteger:7 forKey:@"numberOfIncorrectGuesses"];
        
        [currentGame newLettersArray];
        [currentGame newWordArray];
        [currentGame newLivesInteger];
        [defaults synchronize];
        
        [currentGame loadWords];
    }
    
    // updates all labels
    [self updateLables];
 
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
    
    GameEngineController *currentGame = [[GameEngineController alloc] init];
    
    // Create new array's in UserDefaults for the word and letters
    [currentGame newLettersArray];
    [currentGame newWordArray];
    [currentGame newLivesInteger];
    
    // updates all labels
    [self updateLables];
    
    [currentGame loadWords];
    
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
    
    GameEngineController *currentGame = [[GameEngineController alloc] init];
    
    NSString *input;
    input = [self.letterInput.text uppercaseString];
    
    // Process alphabetical input with 1 character
    if ([currentGame inputSizeCheck:input] && [currentGame inputFormatCheck: input]){
        
        // Check if letter is already guessed
        if ([currentGame inputLettersArrayCheck:input]) {
            
            // Removes letter from array
            [currentGame wordUpdate:input];
            [currentGame lettersUpdate:input];
            [currentGame livesUpdate];
            
            // Update labels
            [self updateLables];
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
    else if (![currentGame inputSizeCheck:input]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No valid input"
                              message:@"It's not allowed to input more than one letter a time"
                              delegate:self
                              cancelButtonTitle:@"Get it!"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Shows alert if input is not the correct format
    else if (![currentGame inputFormatCheck: input]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No alphabetical input"
                              message:@"It's not allowed to input other than basic alphabetical characters"
                              delegate:self
                              cancelButtonTitle:@"Get it!"
                              otherButtonTitles:nil];
        [alert show];
    }

    // Empty input field
    self.letterInput.text = @"";
    return NO;
}

// Function updates all labels
- (void) updateLables {
    
    GameEngineController *currentGame = [[GameEngineController alloc] init];
    
    self.lettersLabel.text = [currentGame newLettersString];
    self.wordLabel.text = [currentGame newWordString];
    self.livesLabel.text = [currentGame newLivesString];
}

@end

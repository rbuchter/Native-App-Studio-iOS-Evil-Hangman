//
//  GameViewController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize letterInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Checks if any userDefault are set
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"numberOfLetters"] == 0){
        [defaults setInteger:5 forKey:@"numberOfLetters"];
        [defaults setInteger:7 forKey:@"numberOfIncorrectGuesses"];
        [defaults setObject:@"_ _ _ _ _ " forKey:@"currentGuessState"];
        [defaults setInteger:7 forKey:@"currentLivesState"];
        [defaults setObject:@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" forKey:@"currentGuessedLettersState"];
        [defaults synchronize];
    }

    // Load the current game form UserDefaults
    self.guessedLettersStateLabel.text = [NSString stringWithFormat:@"%@", [defaults objectForKey:@"currentGuessedLettersState"]];
    self.livesStateLabel.text = [NSString stringWithFormat: @"%ld", (long)[defaults integerForKey:@"currentLivesState"]];
    self.guessStateLabel.text = [NSString stringWithFormat:@"%@", [defaults objectForKey:@"currentGuessState"]];
 
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
- (IBAction)newGame:(UIButton *)sender {
    
    // Updates livesStateLabel and currentLivesState in UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.livesStateLabel.text = [NSString stringWithFormat: @"%ld", (long)[defaults integerForKey:@"numberOfIncorrectGuesses"]];
    // Save currentLivesState to UserDefaults
    [defaults setInteger: [defaults integerForKey:@"numberOfIncorrectGuesses"] forKey:@"currentLivesState"];
    

    // Creates a string with placeholders '_' for the letters of the word to guess
    NSString *guessState = @"";
    for (int i = 1; i <= (long)[defaults integerForKey:@"numberOfLetters"]; i++)
    {
        guessState = [guessState stringByAppendingFormat:@"_ "];
        
    }
    
    // Updates guessStateLabel and currentGuessState in UserDefaults
    self.guessStateLabel.text = [NSString stringWithFormat:@"%@", guessState];
    [defaults setObject:guessState forKey:@"currentGuessState"];
    
    // Updates guessedLettersStateLabel and currentGuessedLettersState in UserDefaults
    [defaults setObject:@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" forKey:@"currentGuessedLettersState"];
    self.guessedLettersStateLabel.text = [NSString stringWithFormat:@"%@", [defaults objectForKey:@"currentGuessedLettersState"]];
    
    [defaults synchronize];
}

// remove keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSLog(@"%@", self.letterInput.text);
    NSString *input = self.letterInput.text;
    NSInteger length = [input length];
    
    NSCharacterSet *lowercaseLetterSet = [NSCharacterSet lowercaseLetterCharacterSet];
    NSCharacterSet *uppercaseLetterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    
    // checks if letter is alphabetical
    if ([[input stringByTrimmingCharactersInSet:lowercaseLetterSet] isEqualToString: @""]|| [[input stringByTrimmingCharactersInSet:uppercaseLetterSet] isEqualToString: @""]) {
        NSLog(@"%s", "ALPHA INPUT");
        
        // checks if not more than 1 letter inputted
        if (length == 1){
            NSLog(@"%s", "1 LETTER");
        }
        else {
            // alert if input is more than 1 letter
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"No valid input"
                                  message:@"It's not allowed to input more than one letter a time"
                                  delegate:self
                                  cancelButtonTitle:@"Get it!"
                                  otherButtonTitles:nil];
            [alert show];
            NSLog(@"%s", "MORE LETTERS");
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No alphabetical input"
                              message:@"It's not allowed to input other than alphabetical characters"
                              delegate:self
                              cancelButtonTitle:@"Get it!"
                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%s", "NO ALPHA INPUT");
    }
    
    return NO;
}

@end

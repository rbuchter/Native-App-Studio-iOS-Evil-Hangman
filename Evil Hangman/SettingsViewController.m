//
//  SettingsViewController.m
//  Evil Hangman
//
//  Viw witch gives the user the posibility to change the settings of the game
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () {
    NSUserDefaults *defaults;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        NSLog(@"VIEWDIDLOAD: SETTINGS");
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    
    // Set value of numberOfLettersLabel and corrosponding slider
    self.sliderNumerOfLettersLabel.text = [ NSString stringWithFormat: @"Number of letters: %ld", (long)[ defaults integerForKey: @"numberOfLetters" ]];
    self.sliderNumberOfLetters.value = (float)[ defaults integerForKey: @"numberOfLetters"];
    
    // Set value of numberOfIncorrectGuessesLabel and corrosponding slider
    self.sliderNumberOfIncorrectGuessesLabel.text = [ NSString stringWithFormat: @"Number of incorrect guesses: %ld", (long) [ defaults integerForKey: @"numberOfIncorrectGuesses" ]];
    self.sliderNumberOfIncorrectGuesses.value = (float)[ defaults integerForKey: @"numberOfIncorrectGuesses" ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Action called when slider with number of letters changed
- (IBAction) sliderNumberOfLettersChanged: (UISlider *) sender {
    
    int value = (int) lroundf ( sender.value );
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    [ defaults setInteger: value forKey:@"numberOfLetters" ];
    [ defaults synchronize ];
    
    self.sliderNumerOfLettersLabel.text = [ NSString stringWithFormat: @"Number of letters: %d", value ];

}

// Action called when slider with number of guesses changed
- (IBAction) sliderNumberOfIncorrectGuessesChanged: (UISlider *) sender {
    
    int value = (int) lroundf ( sender.value );
    
    defaults = [ NSUserDefaults standardUserDefaults ];
    [ defaults setInteger: value forKey: @"numberOfIncorrectGuesses" ];
    [ defaults synchronize ];
    
    self.sliderNumberOfIncorrectGuessesLabel.text = [ NSString stringWithFormat: @"Number of incorrect guesses: %d", value ];
}

@end

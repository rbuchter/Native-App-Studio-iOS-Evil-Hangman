//
//  SettingsViewController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Set value of numberOfLettersLabel and corrosponding slider
    self.sliderNumerOfLettersLabel.text = [NSString stringWithFormat: @"Number of letters: %ld", (long)[defaults integerForKey:@"numberOfLetters"]];
    self.sliderNumberOfLetters.value = (float)[defaults integerForKey:@"numberOfLetters"];
    
    // Set value of numberOfIncorrectGuessesLabel and corrosponding slider
    self.sliderNumberOfIncorrectGuessesLabel.text = [NSString stringWithFormat:@"Number of incorrect guesses: %ld", (long)[defaults integerForKey:@"numberOfIncorrectGuesses"]];
    self.sliderNumberOfIncorrectGuesses.value = (float)[defaults integerForKey:@"numberOfIncorrectGuesses"];
    
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
- (IBAction)sliderNumberOfLettersChanged:(UISlider *)sender {
    int progress = (int)lroundf(sender.value);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: progress forKey:@"numberOfLetters"];
    [defaults synchronize];
    self.sliderNumerOfLettersLabel.text = [NSString stringWithFormat:@"Number of letters: %d", progress];

}
- (IBAction)sliderNumberOfIncorrectGuessesChanged:(UISlider *)sender {
    int progress = (int)lroundf(sender.value);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: progress forKey:@"numberOfIncorrectGuesses"];
    [defaults synchronize];
    self.sliderNumberOfIncorrectGuessesLabel.text = [NSString stringWithFormat:@"Number of incorrect guesses: %d", progress];
}

@end

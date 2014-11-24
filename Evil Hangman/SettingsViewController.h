//
//  SettingsViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

// slider labels outles
@property (weak, nonatomic) IBOutlet UILabel *sliderNumerOfLettersLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;

// slider outlets
@property (weak, nonatomic) IBOutlet UISlider *sliderNumberOfLetters;
@property (weak, nonatomic) IBOutlet UISlider *sliderNumberOfIncorrectGuesses;
@end

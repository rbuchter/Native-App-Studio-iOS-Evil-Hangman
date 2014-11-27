//
//  SettingsViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

// Slider labels outles
@property (strong, nonatomic) IBOutlet UILabel *sliderNumerOfLettersLabel;
@property (strong, nonatomic) IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;

// Slider outlets
@property (strong, nonatomic) IBOutlet UISlider *sliderNumberOfLetters;
@property (strong, nonatomic) IBOutlet UISlider *sliderNumberOfIncorrectGuesses;

@end

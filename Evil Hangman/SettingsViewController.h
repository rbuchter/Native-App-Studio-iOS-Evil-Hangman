//
//  SettingsViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 19-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *sliderNumberOfLettersLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;

- (IBAction)sliderNumerOfIncorrectGuessesChanged:(UISlider *)sender;
- (IBAction)sliderNumberOfLettersChanged:(UISlider *)sender;

@end

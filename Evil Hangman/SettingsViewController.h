//
//  SettingsViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *sliderNumerOfLettersLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;
@end

//
//  SettingsViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 19-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController {
    IBOutlet UILabel *sliderNumberOfLettersLabel;
    IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;
}

@end

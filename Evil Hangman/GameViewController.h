//
//  GameViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *guessedLettersStateLabel;
@property (strong, nonatomic) IBOutlet UILabel *guessStateLabel;
@property (strong, nonatomic) IBOutlet UILabel *livesStateLabel;
@property (strong, nonatomic) IBOutlet UITextField *letterInput;

@end

//
//  GameViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *guessedLettersStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesStateLabel;


@end

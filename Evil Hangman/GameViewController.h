//
//  GameViewController.h
//  Evil Hangman
//
//  Created by Rick Buchter on 24-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

// Outlets to labels of view
@property (strong, nonatomic) IBOutlet UILabel *lettersLabel;
@property (strong, nonatomic) IBOutlet UILabel *wordLabel;
@property (strong, nonatomic) IBOutlet UILabel *livesLabel;

// Outlet to text input field
@property (strong, nonatomic) IBOutlet UITextField *letterInput;

@end

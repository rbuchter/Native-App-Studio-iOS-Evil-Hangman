//
//  SettingsViewController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 17-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *silderNumberOfLettersLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.silderNumberOfLettersLabel.text = @"Number of letters: 5";
    self.sliderNumberOfIncorrectGuessesLabel.text = @"Number of incorrect guesses: 7";
    // Do any additional setup after loading the view.
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
    int progress = lroundf(sender.value);
    self.silderNumberOfLettersLabel.text = [NSString stringWithFormat:@"Number of letters:  %d", progress];
}
- (IBAction)sliderNumberOfIncorrectGuessesChanged:(UISlider *)sender {
    int progress = lroundf(sender.value);
    self.sliderNumberOfIncorrectGuessesLabel.text = [NSString stringWithFormat:@"Number of incorrect guesses: %d", progress];
}




@end

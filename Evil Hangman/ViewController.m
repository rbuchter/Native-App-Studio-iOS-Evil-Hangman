//
//  ViewController.m
//  Evil Hangman
//
//  Created by Rick Buchter on 18-11-14.
//  Copyright (c) 2014 Rick Buchter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sliderNumberOfLettersLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderNumberOfIncorrectGuessesLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sliderNumberOfLettersLabel.text = @"Number of letters: 5";
    self.sliderNumberOfIncorrectGuessesLabel.text = @"Number of letters: 7";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderNumberOfLettersChanged:(UISlider *)sender {
    int progress = lroundf(sender.value);
    self.sliderNumberOfLettersLabel.text = [NSString stringWithFormat:@"Number of letters: %d", progress];
}
- (IBAction)sliderNumerOfIncorrectGuessesChanged:(UISlider *)sender {
    int progress = lroundf(sender.value);
    self.sliderNumberOfIncorrectGuessesLabel.text = [NSString stringWithFormat:@"Number of incorrect guesses: %d", progress];
}

@end

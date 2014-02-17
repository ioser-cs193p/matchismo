//
//  CardGameHistoryViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 2/16/14.
//  Copyright (c) 2014 remillet. All rights reserved.
//

#import "CardGameHistoryViewController.h"

@interface CardGameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@property (weak, nonatomic) NSString *historyText;

@end

@implementation CardGameHistoryViewController

- (void) setHistory:(NSString *)historyString
{
	self.historyText = historyString;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
	self.historyTextView.text = self.historyText;
}

@end

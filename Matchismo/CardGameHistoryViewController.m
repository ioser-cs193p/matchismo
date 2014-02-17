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
@property (weak, nonatomic) NSAttributedString *historyText;

@end

@implementation CardGameHistoryViewController

- (void) setHistory:(NSAttributedString *)historyString
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
	self.historyTextView.attributedText = self.historyText;
}

@end

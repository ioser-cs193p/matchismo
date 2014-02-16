//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 11/17/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override
- (NSAttributedString *) getAttributedContentsForCard:(Card *)card
{
	PlayingCard *playingCard = (PlayingCard *)card;
	NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[playingCard contents]
																			   attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:9.0]}];
	
	return result;

}

//
// Override - overrides to create a deck of PlayingCard's
//
- (Deck *)createDeck
{
	return [[PlayingCardDeck alloc] init];
}

//
// Override
//
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
	NSLog(@"The name of the segue is %@", identifier);
	return YES;
}

@end

//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "Card.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// Custom code
//

- (Deck *)deck
{
	if (_deck == nil) {
		_deck = [[PlayingCardDeck alloc] init];
	}
	
	return _deck;
}

- (IBAction)touchCardButton:(UIButton *)sender {
	Card *card = nil;
	
	if ([self.deck count] > 0) {
		if ([sender.currentTitle length] > 0) {
			[sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
							  forState:UIControlStateNormal];
			[sender setTitle:@"" forState:UIControlStateNormal];
		} else {
			card = [self.deck drawRandomCard];
			[sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
							  forState:UIControlStateNormal];
			[sender setTitle:[card contents] forState:UIControlStateNormal];
		}
		self.flipCount++;
		[self.flipsLabel setText:[NSString stringWithFormat:@"Flips: %d", self.flipCount]];
	} else {
		[self.flipsLabel setText:[NSString stringWithFormat:@"Flips: %d. Deck is emtpy.", self.flipCount]];
	}
}


@end

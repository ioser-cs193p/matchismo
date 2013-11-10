//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "Card.h"

@interface CardGameViewController ()


@property (strong, nonatomic) CardMatchingGame *gameModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtonList;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

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

//
// Start with a new Deck
//
- (IBAction)redeal:(UIButton *)sender {
	_gameModel = nil;
	[self updateUI];
}

- (CardMatchingGame *)gameModel
{
	if (_gameModel == nil) {
		_gameModel = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtonList count]
													   usingDeck:[self createDeck]];
	}
	
	return _gameModel;
}

// Should move this method to an override method in PlayingCardDeck class
- (Deck *)createDeck
{
	return [[PlayingCardDeck alloc] init];
}

- (void)updateUI
{
	for (int i = 0; i < [self.cardButtonList count]; i++) {
		Card *card = [self.gameModel cardAtIndex:i];
		UIButton *cardButton = self.cardButtonList[i];
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [self.gameModel score]]];
}

- (NSString *)titleForCard:(Card *)card
{
	NSString * result = @"";
	
	if (card.isChosen) {
		result = card.contents;
	}
	
	return result;
}

- (UIImage *)imageForCard:(Card *)card
{
	UIImage *result = [UIImage imageNamed:@"cardback"];
	
	if (card.isChosen) {
		result = [UIImage imageNamed:@"cardfront"];
	}
	
	return result;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
	int index = [self.cardButtonList indexOfObject:sender];
	[self.gameModel chooseCardAtIndex:index];
	[self updateUI];
	NSLog(@"Touched button at index %d contains card %@", index, [self.gameModel cardAtIndex:index].contents);
}


@end

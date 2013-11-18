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
#import "Card.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *gameModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtonList;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardsToMatchControl;
@property (weak, nonatomic) IBOutlet UILabel *lastActionMessage;

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
- (IBAction)segmentedControlTouched:(UISegmentedControl *)sender {
	NSInteger segmentSelected = [sender selectedSegmentIndex];
	NSLog(@"Segment %d selected.", segmentSelected);
}

//
// Start with a new Deck
//
- (IBAction)redeal:(UIButton *)sender {
	_gameModel = nil;
	[self updateUI];
}

- (NSUInteger)numberOfCardsToCompare
{
	NSUInteger result = 1;
	
	// Get the selected selegment control value.  If it is greater than 0, use that value.
	// Otherwise, use 0.
	// 1 means match 2 cards
	// 2 means match 3 cards
	// n means match n + 1 cards
	NSInteger selectedSegmentIndex = [self.cardsToMatchControl selectedSegmentIndex];
	if (selectedSegmentIndex > 0) {
		result = selectedSegmentIndex + 1;
	}
	
	return result;
}

- (CardMatchingGame *)gameModel
{
	if (_gameModel == nil) {
		_gameModel = [[CardMatchingGame alloc] initWithCardCount: [self.cardButtonList count]
													   usingDeck: [self createDeck]
													 numberOfCardsToCompare: [self numberOfCardsToCompare]];
	}
		
	return _gameModel;
}

// Should move this method to an override method in PlayingCardDeck class
- (Deck *)createDeck
{
	NSLog(@"ERROR: Should never call this method.  Subclasses need to override.");
	return nil;
}

- (void)updateUI
{
	self.cardsToMatchControl.enabled = _gameModel == nil;
	
	for (int i = 0; i < [self.cardButtonList count]; i++) {
		Card *card = [self.gameModel cardAtIndex:i];
		UIButton *cardButton = self.cardButtonList[i];
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	NSString *lastActionMessage = [[self.gameModel actionMessageList] lastObject];
	NSLog(@"Last message %@", lastActionMessage);
	[self.lastActionMessage setText: lastActionMessage];
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

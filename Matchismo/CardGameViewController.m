//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//
//	This is an abstract class meant for concrete card game controllers.

#import "CardMatchingGame.h"
#import "CardGameViewController.h"
#import "CardGameHistoryViewController.h"
#import "CardGameAction.h"
#import "Deck.h"
#import "Card.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *gameModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtonList;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
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
// This is an abstract method.
//
- (UIImage *)imageForCard:(Card *)card
{
	[NSException raise:@"An overriding method needs to be implemented in a subclass." format:@"Method not implemented in subclass: of %@ is invalid", @"imageForCard"];
	return nil;
}

- (NSString *) stringFromCardList:(NSArray *)cardList
{
	NSMutableString *result = [[NSMutableString alloc] init];
	
	for (int i = 0; i < cardList.count; i++) {
		Card *card = [cardList objectAtIndex:i];
		[result appendString:card.description];
		if (i < cardList.count - 1) {
			[result appendString:@", "];
		}
	}
	
	return result;
}

/*
 * Return an attributed string verion of a message where each card title is returned as an attributed
 * string version.
 *
 */
- (NSAttributedString *) attributedStringFromString:(NSString *)string andCardList:(NSArray *)cardList
{
	NSMutableString *tempStr = [NSMutableString stringWithString:string];
	NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
	
	for (Card *card in cardList) {
		NSRange range = [tempStr rangeOfString:card.description];
		[result replaceCharactersInRange:range withAttributedString:[self getAttributedContentsForCard:card]];
		[tempStr replaceCharactersInRange:range withString:card.contents];
	}
	
	return result;
}

- (NSAttributedString *)getAttributedStringFromAction: (CardGameAction *)action
{
	NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
	
	NSString *actionString = nil;
	switch (action.predicate) {
		case CARD_GAME_ACTION_UNCHOSE:
			actionString = [[NSString alloc] initWithFormat: @"Unchose card %@.", [self stringFromCardList:action.cardList]];
			[result appendAttributedString:[self attributedStringFromString:actionString andCardList:action.cardList]];
			break;
			
		case CARD_GAME_ACTION_MATCH:
			actionString = [[NSString alloc] initWithFormat: @"Matched %@ for %d points.", [self stringFromCardList:action.cardList], action.points];
			[result appendAttributedString:[self attributedStringFromString:actionString andCardList:action.cardList]];
			break;
			
		case CARD_GAME_ACTION_NOMATCH:
			actionString = [[NSString alloc] initWithFormat: @"No matches for %@. %d points substracted.", [self stringFromCardList:action.cardList], action.points];
			[result appendAttributedString:[self attributedStringFromString:actionString andCardList:action.cardList]];
			break;
			
		case CARD_GAME_ACTION_CHOSE:
			actionString = [[NSString alloc] initWithFormat: @"Chose card %@.", [self stringFromCardList:action.cardList]];
			[result appendAttributedString:[self attributedStringFromString:actionString andCardList:action.cardList]];
			break;
			
		default:
			break;
	}
	
	return result;
}

- (NSAttributedString *) getHistory
{
	NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
	NSAttributedString *returnLine = [[NSAttributedString alloc] initWithString:@"\n"];
	
	for (CardGameAction *action in [self.gameModel cardGameActionList]) {
		NSAttributedString *attributedStringMessage = [self getAttributedStringFromAction:action];
		[result appendAttributedString:attributedStringMessage];
		[result appendAttributedString:returnLine];
	}
	
	return result;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGameHistoryViewController class]]) {
            CardGameHistoryViewController *historyViewController = (CardGameHistoryViewController *)segue.destinationViewController;
            [historyViewController setHistory:[self getHistory]];
        }
    }
}

//
// Subclasses must override this method.  Need to return an attributed string
// that describes a card.
//
- (NSAttributedString *) getAttributedContentsForCard:(Card *)card
{
	return nil;
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

- (NSAttributedString *)getLastActionMessage
{
	CardGameAction *lastAction = [[self.gameModel cardGameActionList] lastObject];
	return [self getAttributedStringFromAction:lastAction];
}

- (void)updateUI
{
	for (int i = 0; i < [self.cardButtonList count]; i++) {
		Card *card = [self.gameModel cardAtIndex:i];
		UIButton *cardButton = self.cardButtonList[i];
		[cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	NSLog(@"Last message %@", [[self.gameModel actionMessageList] lastObject]);
	[self.lastActionMessage setAttributedText:[self getLastActionMessage] ];
	
	[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [self.gameModel score]]];
}

- (NSAttributedString *) attributedTitleForCard:(Card *)card
{
	return [self getAttributedContentsForCard:card];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
	int index = [self.cardButtonList indexOfObject:sender];
	[self.gameModel chooseCardAtIndex:index];
	[self updateUI];
	NSLog(@"Touched button at index %d contains card %@", index, [self.gameModel cardAtIndex:index].description);
}


@end

//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Richard E Millet on 11/8/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardGameAction.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // of type Card
@property (nonatomic)NSUInteger numberOfCardsToCompare; // # of cards in match check
@property (nonatomic, readwrite, strong)NSMutableArray *actionMessageList;
@property (nonatomic, readwrite, strong)NSMutableArray *cardGameActionList;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cardGameActionList
{
	if (_cardGameActionList == nil) {
		_cardGameActionList = [[NSMutableArray alloc] init];
	}
	
	return _cardGameActionList;
}

- (void)addCardGameAction:(CardGameAction *)cardGameAction
{
	[self.cardGameActionList addObject:cardGameAction];
}

- (NSMutableArray *)actionMessageList
{
	if (_actionMessageList == nil) {
		_actionMessageList = [[NSMutableArray alloc] init];
	}
	
	return _actionMessageList;
}

- (void)addActionMessage:(NSString *)actionMessage
{
	[self.actionMessageList addObject:actionMessage];
}

- (NSMutableArray *)cards
{
	if (_cards == nil) {
		_cards = [[NSMutableArray alloc] init];
	}
	
	return _cards;
}

//
// Designated initializer
//
- (instancetype)initWithCardCount: (NSUInteger)count
						usingDeck: (Deck *)deck
		   numberOfCardsToCompare: (NSUInteger)numberOfCardsToCompare
{
	self = [super init];
	
	if (self != nil) {
		if (count >= 2) {
			for (int i = 0; i < count; i++) {
				Card *card = [deck drawRandomCard];
				if (card != nil) {
					[self.cards addObject:card];
				} else {
					self = nil; // initialization failed
					break;
				}
			}
		}
		self.numberOfCardsToCompare = numberOfCardsToCompare;
		NSLog(@"Game initialized in card matching mode of %d", numberOfCardsToCompare);
	}
	
	return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
	Card *result = nil;
	
	if (index < [self.cards count]) {
		result = self.cards[index];
	}
	
	return result;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int FLIP_COST = 1;
static const int REQUIRED_MATCHES = 1;

//
// Return a list of chosen (but unmatched) cards.
//
- (NSArray *)chosenCards
{
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (Card *card in self.cards) {
		if (card.isChosen && card.isMatched == NO) {
			[results addObject:card];
		}
	}
	
	return [results copy];
}

- (NSString *)cardListAsString:(NSArray *)cardList
{
	NSString *result = @"";
	
	for (Card *card in cardList) {
		result = [result stringByAppendingFormat:@" %@", card.contents];
	}
	
	result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	return result;
}

- (void)markCardsAsMatched:(NSArray *)cardList
{
	for (Card *card in cardList) {
		card.matched = YES;
	}
}

- (void)markCardsAsUnchosen:(NSArray *)cardList
{
	for (Card *card in cardList) {
		card.chosen = NO;
	}
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	NSString *message = nil;
	CardGameAction *action = nil;
		
	if (card != nil && card.isMatched == NO) {
		if (card.isChosen) {
			card.chosen = NO;
			message = [NSString stringWithFormat:@"Unchose card %@", card.contents];
			action = [CardGameAction initWithPredicate:CARD_GAME_ACTION_UNCHOSE cardList:@[card]];
		} else if (card != nil) {
			NSArray *chosenCardList = [self chosenCards];
			if ([chosenCardList count] == self.numberOfCardsToCompare) {
				NSArray *cardsToCompare = [chosenCardList arrayByAddingObject:card];
				int matchScore = [Card match:cardsToCompare numberOfRequiredMatches:REQUIRED_MATCHES];
				if (matchScore > 0) {
					self.score += matchScore * MATCH_BONUS;
					card.matched = YES;
					[self markCardsAsMatched:chosenCardList];
					message = [NSString stringWithFormat:@"Matched %@ for %d points.", [self cardListAsString:cardsToCompare], matchScore * MATCH_BONUS];
					action = [CardGameAction initWithPredicate:CARD_GAME_ACTION_MATCH cardList:cardsToCompare points:matchScore * MATCH_BONUS];
				} else {
					self.score -= MISMATCH_PENALTY;
					[self markCardsAsUnchosen:chosenCardList];
					message = [NSString stringWithFormat:@"No matches for %@. %d points substracted.", [self cardListAsString:cardsToCompare], MISMATCH_PENALTY];
					action = [CardGameAction initWithPredicate:CARD_GAME_ACTION_NOMATCH cardList:cardsToCompare points:MISMATCH_PENALTY];
				}
			} else {
				message = [NSString stringWithFormat:@"Chose card %@", card.contents];
				action = [CardGameAction initWithPredicate:CARD_GAME_ACTION_CHOSE cardList:@[card]];
			}
			self.score -= FLIP_COST;
			card.chosen = YES;
		}
	}
	
	if (card != nil) {
		[self addActionMessage:message];
		[self addCardGameAction:action];
	}
	
	NSLog(@"Last action message: %@", message);
}

@end

//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Richard E Millet on 11/8/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // of type Card
@property (nonatomic)NSUInteger matchMode; // # of cards in match check

@end

@implementation CardMatchingGame

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
						usingDeck:(Deck *)deck
					  inMatchMode:(NSUInteger)matchMode
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
		self.matchMode = matchMode;
		NSLog(@"Game initialized in card matching mode of %d", matchMode);
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
	
	if (card != nil && card.isMatched == NO) {
		if (card.isChosen) {
			card.chosen = NO;
		} else {
			NSArray *chosenCardList = [self chosenCards];
			if ([chosenCardList count] == self.matchMode) {
				NSLog(@"Comparing %@ to [%@]", card.contents, [self cardListAsString:chosenCardList]);
//				int matchScore = [card match:chosenCardList];
				int matchScore = [Card match:[chosenCardList arrayByAddingObject:card] numberOfRequiredMatches:1];
				if (matchScore > 0) {
					self.score += matchScore * MATCH_BONUS;
					card.matched = YES;
					[self markCardsAsMatched:chosenCardList];
				} else {
					self.score -= MISMATCH_PENALTY;
					[self markCardsAsUnchosen:chosenCardList];
				}
			}
			self.score -= FLIP_COST;
			card.chosen = YES;
		}
	}
}

@end

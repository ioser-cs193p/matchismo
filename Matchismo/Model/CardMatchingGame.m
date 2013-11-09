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
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
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

- (void)chooseCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	if (card != nil && card.isMatched == NO) {
		if (card.isChosen) {
			card.chosen = NO;
		} else {
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && otherCard.isMatched == NO) {
					int matchScore = [otherCard match:@[card]];
					if (matchScore > 0) {
						self.score += matchScore * MATCH_BONUS;
						card.matched = YES;
						otherCard.matched = YES;
					} else {
						self.score -= MISMATCH_PENALTY;
						otherCard.chosen = NO;
					}
					break; // we're finished since we did a comparison
				}
			}
			self.score -= FLIP_COST;
			card.chosen = YES;
		}
	}
}

@end

//
//  Deck.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation Deck

- (NSMutableArray *)cards
{
	if (_cards == Nil) {
		_cards = [[NSMutableArray alloc] init];
	}
	
	return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
	if (atTop) {
		[self.cards insertObject:card atIndex:0];
	} else {
		[self.cards addObject:card];
	}
}

- (void)addCard:(Card *)card
{
	[self addCard:card atTop:NO];
}

- (NSUInteger)count
{
	return [self.cards count];
}

- (Card *)drawRandomCard
{
	Card *result = nil;
	
	if ([self.cards count] > 0) {
		unsigned index = arc4random() % [self.cards count];
		result = [self.cards objectAtIndex:index]; // self.cards[index]
		[self.cards removeObjectAtIndex:index];
		NSLog(@"Removed a card.  %d cards remaining.", [self.cards count]);
	} else {
		NSLog(@"No more cards.  The deck is empty.");
	}
	
	return result;
}

@end

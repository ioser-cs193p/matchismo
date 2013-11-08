//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Richard E Millet on 11/7/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
	self = [super init];
	
	if (self != nil) {
		for (NSString *suit in [PlayingCard validSuits]) {
			for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
				PlayingCard *card = [[PlayingCard alloc] init];
				card.suit = suit;
				card.rank = rank;
				[self addCard:card];
			}
		}
	}
	
	NSLog(@"Allocated a set of %d playing cards.", [self count]);
	
	return self;
}

@end

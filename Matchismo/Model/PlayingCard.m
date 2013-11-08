//
//  PlayingCard.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//
// Since we're overriding both the setter and getter, we need to synthesize
// the suit instance member
//
@synthesize suit = _suit;

- (NSString *)suit
{
	return _suit != nil ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
	if ([[PlayingCard validSuits] containsObject:suit]) {
		_suit = suit;
	}
}

- (void)setRank:(NSUInteger)rank
{
	if (rank <= [PlayingCard maxRank]) {
		_rank = rank;
	}
}

//
// Private Methods
//
+ (NSArray *)rankStrings
{
	return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

//
// Inherited Public Methods
//
- (NSString *)contents
{
	return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}


//
// Public Methods
//
+ (NSArray *) validSuits
{
	return @[@"♠", @"♣", @"♥", @"♦"];
}

+ (NSUInteger) maxRank
{
	NSArray *rankStrings = [PlayingCard rankStrings];
	NSUInteger result = [[self rankStrings] count] - 1;
	return result;
}

@end

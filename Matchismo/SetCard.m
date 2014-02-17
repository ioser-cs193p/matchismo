//
//  SetCard.m
//  Matchismo
//
//  Created by Richard E Millet on 11/18/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "REMLogger.h"
#import "SetCard.h"

//
// Use these characters: ▲ ● ■ for drawing the Set cards
//

@implementation SetCard

+ (SetCard *)newWithRank: (NSUInteger)rank symbol:(NSString *)symbol shadingNumber:(NSNumber *)shadingNumber color:(UIColor *)color
{
	ShadingType shading = (ShadingType)[shadingNumber integerValue];
	return [self newWithRank:rank symbol:symbol shading:shading color:color];
}

+ (SetCard *)newWithRank: (NSUInteger)rank symbol:(NSString *)symbol shading:(ShadingType)shading color:(UIColor *)color
{
	return [[SetCard alloc] initWithRank:rank symbol:symbol shading:shading color:color];
}

+ (NSArray *) validSuits
{
	return @[@"▲", @"●", @"■"];
}

+ (NSArray *) validColors
{
	return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *) validShades
{
	return @[[NSNumber numberWithInteger:ShadingTypeOpen],
			 [NSNumber numberWithInteger:ShadingTypeStriped],
			 [NSNumber numberWithInteger:ShadingTypeSolid]];
}


+ (NSUInteger) maxRank {
	return [[self validSuits] count];
}

+ (NSString *) colorToString: (UIColor *)color
{
	NSString *result = nil;
	
	if ([color isEqual:[UIColor redColor]]) {
		result = @"red";
	} else if ([color isEqual:[UIColor greenColor]]) {
		result = @"green";
	} else if ([color isEqual:[UIColor blueColor]]) {
		result = @"blue";
	} else {
		result = @"unknown";
	}
	
	return result;
}

+ (NSString *) shadingToString: (ShadingType)shading
{
	NSString * result = nil;
	
	switch (shading) {
		case ShadingTypeSolid:
			result = @"solid";
			break;
		case ShadingTypeStriped:
			result = @"striped";
			break;
		case ShadingTypeOpen:
			result = @"open";
			break;
		default:
			break;
	}
	
	return result;
}

- (instancetype)initWithRank: (NSUInteger)rank symbol:(NSString *)symbol shading:(NSUInteger)shading color:(UIColor *)color
{
	self = [super init];
	
	if (self != nil) {
		self.rank = rank;
		self.symbol = symbol;
		self.shading = shading;
		self.color = color;
	}
	
	return self;
}

- (NSString *) getSymbolAndRankString
{
	NSMutableString *result = [[NSMutableString alloc] init];
	for (int i = 0; i < self.rank; i++) {
		[result appendString:self.symbol];
	}
	
	return result;
}

/*
 * Forms a set if all the cards either have the same color or they all have different colors
 */
- (BOOL)formsColorSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if (([card1.color isEqual:card2.color] && [card2.color isEqual:card3.color]) ||
		(![card1.color isEqual:card2.color] && ![card2.color isEqual:card3.color] && ![card1.color isEqual:card3.color])) {
		result = YES;
	}
	
	return result;
}

- (BOOL)formsFillSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if ((card1.shading == card2.shading && card2.shading == card3.shading) ||
		(card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading)) {
		result = YES;
	}
	
	return result;
}

- (BOOL)formsRankSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if ((card1.rank == card2.rank && card2.rank == card3.rank) ||
		(card1.rank != card2.rank && card2.rank != card3.rank && card1.rank != card3.rank)) {
		result = YES;
	}
	
	return result;
}

- (BOOL)formsSuitSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if (([card1.symbol isEqual:card2.symbol] && [card2.symbol isEqual:card3.symbol]) ||
		(![card1.symbol isEqual:card2.symbol] && ![card2.symbol isEqual:card3.symbol] && ![card1.symbol isEqual:card3.symbol])) {
		result = YES;
	}
	
	return result;
}

- (BOOL) isInAllSets:(NSArray *)cardList {
	BOOL result = YES;
	
	if ([self formsColorSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Color set test failed.");
	} else if ([self formsFillSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Fill set test failed.");
	} else if ([self formsRankSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Rank set test failed.");
	} else if ([self formsSuitSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Suit set test failed.");
	}
	
	return result;
}

//
// Override the match method.  Making it specific to the PlayingCard class
//
- (int)match:(NSArray *)otherCardsList {
	int result = 0;
	
	if (otherCardsList.count == 2) {
		if ([self isInAllSets:otherCardsList] == YES) {
			result = 10;
		}
	} else {
		[NSException raise:@"Not the correct number of objects for a Set." format:@"otherCards array size needs to be 2 but was %d.", otherCardsList.count];
	}
	
	return result;
}

//
// Inherited Public Methods
//
- (NSString *)contents
{
	return [self getSymbolAndRankString];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"Rank:%d Suit:%@ Shading:%@ Color:%@",
			self.rank, self.symbol, [[self class] shadingToString:self.shading],
			[[self class] colorToString:self.color]];
}

@end

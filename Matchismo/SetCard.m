//
//  SetCard.m
//  Matchismo
//
//  Created by Richard E Millet on 11/18/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

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

//
// Inherited Public Methods
//
- (NSString *)contents
{
	return [self description];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"Rank:%d Suit:%@ Shading:%@ Color:%@",
			self.rank, self.symbol, [[self class] shadingToString:self.shading],
			[[self class] colorToString:self.color]];
}

@end

//
//  SetDeck.m
//  Matchismo
//
//  Created by Richard E Millet on 11/17/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)init
{
	self = [super init];
	
	if (self != nil) {
		for (NSString *suit in [SetCard validSuits]) {
			for (NSUInteger rank = 1; rank <= [SetCard maxRank]; rank++) {
				for (NSNumber *shading in [SetCard validShades]) {
					for (UIColor *color in [SetCard validColors]) {
						SetCard *setCard = [SetCard newWithRank:rank symbol:suit shadingNumber:shading color:color];
						[self addCard:setCard];
						NSLog(@"Addded card to Set deck: %@", [setCard description]);
					}
				}
			}
		}
	}
	
	NSLog(@"Initialized Set deck with %d cards.", [self count]);
	
	return self;
}
@end

//
//  Card.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
	int score = 0;
	
	for (Card *card in otherCards) {
		if ([card.contents isEqualToString:self.contents]) {
			score = 1;
		}
	}
	
	return score;
}

@end

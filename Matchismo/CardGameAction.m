//
//  CardGameAction.m
//  Matchismo
//
//  Created by Richard E Millet on 2/16/14.
//  Copyright (c) 2014 remillet. All rights reserved.
//

#import "CardGameAction.h"

@implementation CardGameAction

+ (CardGameAction *) initWithPredicate:(int)predicate cardList:(NSArray *)cardList
{
	return [self initWithPredicate:predicate cardList:cardList points:0];
}

+ (CardGameAction *) initWithPredicate:(int)predicate cardList:(NSArray *)cardList points:(int)points
{
	CardGameAction *result = [[CardGameAction alloc] init];

	if (result != nil) {
		result.predicate = predicate;
		result.cardList = cardList;
		result.points = points;
	}
	
	return result;
}

@end

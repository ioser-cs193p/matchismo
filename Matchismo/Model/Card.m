//
//  Card.m
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "math.h"
#import "Card.h"

//
// A structure to keep track of a match score and number of matches when
// comparing a Card instance to an array of other Card instances.
//
typedef struct MatchResult
{
	int matches;
	int matchScore;
} MatchResult;

@implementation Card

//
// Creates a subarray of 'cardList' starting a index 'index'
//
+ (NSArray *)cloneCardList:(NSArray *)cardList startingAtIndex:(NSUInteger)index
{
	return [cardList subarrayWithRange:NSMakeRange(index, [cardList count] - 1)];
}

//
// Add two MatchResult instances and return the results.
//
+ (MatchResult)addLeft:(MatchResult)left toRight:(MatchResult)right
{
	left.matches += right.matches;
	left.matchScore += right.matchScore;
	return left;
}

//
// Returns the total number of matches possible for 'numberOfCard' cards.  For example, 5 cards has
// 10 possible matches -i.e., (5-1 + 4-1 + 3-1 + 2-1)
//
+ (int)maxMatches:(int)numberOfCards
{
	int result = 0;
	
	if (numberOfCards > 1) {
		result += numberOfCards - 1 + [Card maxMatches:numberOfCards - 1];
	}
	
	return result;
}

//
// Will try to find at least 'numberOfRequiredMatches' matches and return the score.  If we don't find
// at least 'numberOfRequiredMatches' then we'll return 0;
//
+ (int)match:(NSArray *)cardList numberOfRequiredMatches:(NSUInteger)numberOfRequiredMatches
{
	int result = 0;
	
	Card *firstCard = cardList[0];
	NSArray *firstArray = [Card cloneCardList:cardList startingAtIndex:1];
	MatchResult matchResult = [Card match:firstCard cardList:firstArray];
	
//	if (matchResult.matches >= numberOfRequiredMatches) {
//		int maxMatches = [Card maxMatches:[cardList count]];
//		float multiplier =  1.0 + (matchResult.matches / (float)maxMatches) * log(maxMatches);  // A percentage of actual matches vs possible matches
//		result = matchResult.matchScore * multiplier;
//
//		NSLog(@"Max matches is %d. Multiplier is %f", maxMatches, multiplier);
//		NSLog(@"Found %d matches of score %d:%d in cards %@", matchResult.matches, matchResult.matchScore, result, cardList);
//	} else {
//		NSLog(@"Not enough matches found.  Needed %d but found only %d.", numberOfRequiredMatches, matchResult.matches);
//	}
	result = matchResult.matchScore;
	return result;
}

//
// Look for all card matching combinations.  Not just between the card 'card' and cards in 'cardList', but between
// all card combinations.  This method makes a recursive call to itself.  The structure MatchResult keeps track of both
// the score and the total number of matches found.
//
+ (MatchResult)match:(Card *)card cardList:(NSArray *)cardList
{
	MatchResult matchResult;
	matchResult.matches = 0;
	matchResult.matchScore = 0;
	
	if ([cardList count] > 0) {
		int score = [card match:cardList];
		if (score > 0) {
			matchResult.matchScore += score;
			matchResult.matches += 1;
		}
	}
	
	return matchResult;
}

- (NSString *)description
{
	return self.contents;
}

//
// Returns the number of matches between ourself and an array of other cards.
//
- (int)getNumberOfMatches:(NSArray *)otherCardList
{
	int matches = 0;
	
	for (Card *otherCard in otherCardList) {
		if ([self doCardsMatch:otherCard]) {
			matches++;
		}
	}
	
	return matches;
}

//
// A convenience method for matching two cards
//
- (BOOL)doCardsMatch:(Card *)otherCard
{
	BOOL result = NO;
	
	if ([self match:@[otherCard]] > 0) {
		result = YES;
	}
	
	return result;
}

//
// You should overide this is subclasses to correspond with those classes' semantics.
//
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

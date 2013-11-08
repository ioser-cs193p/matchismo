//
//  PlayingCard.h
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end

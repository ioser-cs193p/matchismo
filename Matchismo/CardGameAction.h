//
//  CardGameAction.h
//  Matchismo
//
//  Created by Richard E Millet on 2/16/14.
//  Copyright (c) 2014 remillet. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CARD_GAME_ACTION_UNCHOSE 0
#define CARD_GAME_ACTION_MATCH 1
#define CARD_GAME_ACTION_NOMATCH 2
#define CARD_GAME_ACTION_CHOSE 3

@interface CardGameAction : NSObject

@property (nonatomic) int predicate;
@property (nonatomic, strong) NSArray *cardList;
@property (nonatomic) int points;

+ (CardGameAction *) initWithPredicate:(int)predicate cardList:(NSArray *)cardList;
+ (CardGameAction *) initWithPredicate:(int)predicate cardList:(NSArray *)cardList points:(int)points;

@end

//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Richard E Millet on 11/8/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly)NSInteger score;
@property (nonatomic, readonly, strong)NSMutableArray *actionMessageList;
@property (nonatomic, readonly, strong)NSMutableArray *cardGameActionList;

//
// Designated initializer
//
- (instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck numberOfCardsToCompare:(NSUInteger)matchMode;

- (void)chooseCardAtIndex: (NSUInteger)index;
- (Card *)cardAtIndex: (NSUInteger)index;

@end

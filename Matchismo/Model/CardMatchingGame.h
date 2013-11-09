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

//
// Designated initializer
//
- (instancetype)initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex: (NSUInteger)index;
- (Card *)cardAtIndex: (NSUInteger)index;

@end

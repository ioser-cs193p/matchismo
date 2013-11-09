//
//  Deck.h
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, readonly)NSUInteger count;

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end

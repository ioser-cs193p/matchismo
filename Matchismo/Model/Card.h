//
//  Card.h
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match:(NSArray *)otherCards;

@end

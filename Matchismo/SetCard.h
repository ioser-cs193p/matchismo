//
//  SetCard.h
//  Matchismo
//
//  Created by Richard E Millet on 11/18/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

typedef NS_ENUM(NSInteger, ShadingType) {
    ShadingTypeOpen,
    ShadingTypeStriped,
    ShadingTypeSolid
};

@property NSUInteger rank;
@property NSString *symbol;
@property NSUInteger shading;
@property UIColor *color;

+ (SetCard *)newWithRank: (NSUInteger)rank symbol:(NSString *)symbol shadingNumber:(NSNumber *)shadingNumber color:(UIColor *)color;

+ (NSArray *) validSuits;

+ (NSUInteger) maxRank;

+ (NSArray *) validShades;

+ (NSArray *) validColors;

@end

//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 11/17/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import "SetGameViewController.h"
#import "Deck.h"
#import "SetDeck.h"
#import "SetCard.h"

//
// Use these characters: ▲ ● ■ for drawing the Set cards
//

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// Override
//
- (NSUInteger)numberOfCardsToCompare
{
	NSUInteger result = 2;
	
	// 1 means match 2 cards
	// 2 means match 3 cards
	// n means match n + 1 cards
	
	return result;
}

//
// Override
//
- (UIImage *)imageForCard:(Card *)card
{
	UIImage *result = [UIImage imageNamed:@"setcardback"];
	
	if (card.isChosen) {
		result = [UIImage imageNamed:@"setcardfront"];
	}
	
	return result;
}

//
// Override - overrides to create a deck of PlayingCard's
//
- (Deck *)createDeck
{
	
	NSLog(@"Created a new set deck.");
	
	return [[SetDeck alloc] init];
}

- (UIColor *) getFillColorAndAlphaForCard:(SetCard *)setCard
{
	UIColor *result = nil;
	
	if (setCard.shading == ShadingTypeOpen) {
		result = [setCard.color colorWithAlphaComponent:0.0];
	} else if (setCard.shading == ShadingTypeStriped) {
		result = [setCard.color colorWithAlphaComponent:0.2];
	} else if (setCard.shading == ShadingTypeSolid) {
		result = setCard.color;
	}
	
	return result;
}

- (NSDictionary *)getAttributesForCard:(SetCard *)setCard
{
	NSDictionary *result = nil;
	
	if (setCard != nil) {
		result = @{ NSStrokeWidthAttributeName : @-3,
				    NSFontAttributeName : [UIFont systemFontOfSize:12.0],
					NSForegroundColorAttributeName : [self getFillColorAndAlphaForCard:setCard],
					NSStrokeColorAttributeName : setCard.color
					};
	}
	
	return result;
}

//
// Returns an attributed string representation of a card
//
- (NSAttributedString *) getAttributedContentsForCard:(Card *)card
{
	SetCard *setCard = (SetCard *)card;
	NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[setCard contents]
																			   attributes:[self getAttributesForCard:setCard]];
	return result;
}


@end

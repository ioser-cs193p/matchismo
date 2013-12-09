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
// Override - overrides to create a deck of PlayingCard's
//
- (Deck *)createDeck
{
	
	NSLog(@"Created a new set deck.");
	
	return [[SetDeck alloc] init];
}

@end

//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Richard E Millet on 11/6/13.
//  Copyright (c) 2013 remillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardGameViewController : UIViewController

- (NSAttributedString *) getAttributedContentsForCard:(Card *)card;
- (UIImage *)imageForCard:(Card *)card;

@end

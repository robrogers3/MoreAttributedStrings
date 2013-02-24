//
//  Deck.h
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
-(void)addCard:(Card *) card atTop: (BOOL) atTop;
-(Card *)drawRandomCard;
@end;

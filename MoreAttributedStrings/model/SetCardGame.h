//
//  SetCardGame.h
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/21/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGame : NSObject
@property (nonatomic,readonly) int score;
@property (nonatomic,readonly) int lastScore;
-(id)initWithCardCount: (NSUInteger) cardCount usingDeck: (Deck *) deck;
-(NSArray *)selectCardAtIndex:(NSUInteger) index;
-(Card *)cardAtIndex:(NSUInteger) index;
@end

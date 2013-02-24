//
//  SetCardGame.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/21/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "SetCardGame.h"
#import "SetCard.h"
@interface SetCardGame()
@property (nonatomic,readwrite) int score;
@property (nonatomic,readwrite) int lastScore;
@property (strong,nonatomic) NSMutableArray *cards;
@end

@implementation SetCardGame
-(NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}
-(id)initWithCardCount: (NSUInteger) cardCount usingDeck: (Deck *) deck
{
    self = [super init];
    if (self) {
        for (int i = 0;i < cardCount;i++) {
            Card *card = (SetCard *)[deck drawRandomCard];
            if (card)
                self.cards[i] = card;
            else {
                self.cards[i] = nil;
                break;
            }
        }
    }
    return self;
}
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define SELCOST 1;
-(NSArray *)selectCardAtIndex:(NSUInteger) index {
    NSMutableArray *playedCards = [[NSMutableArray alloc] init];
    int matchScore = 0;
    self.lastScore = 0;
    SetCard *card = (SetCard *)[self cardAtIndex:index];
    if (card && !card.isUnplayable) {
        if (!card.isSelected)
        {
            for (SetCard *c in self.cards) { //accumulate
                if ([playedCards count] == 2)
                    break;
                if (!c.isUnplayable && c.isSelected) {
                    [playedCards addObject:c];
                }
            }
            if ([playedCards count] == 2 ) {
                matchScore = [card match:playedCards];
                if (matchScore) {
                    self.score += matchScore + MATCH_BONUS;
                    self.lastScore = matchScore + MATCH_BONUS;
                    
                    card.unplayable = YES;
                    for (SetCard *c in playedCards) {
                        c.unplayable = YES;
                        c.selected = NO;
                    }
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.lastScore =  matchScore - MISMATCH_PENALTY;
                    for (SetCard *c in playedCards) {
                        c.unplayable = NO;
                        c.selected = NO;
                    }
                }
            }
            if (![playedCards containsObject:card])
                [playedCards addObject:card];
            self.score -= SELCOST;
        } else {
            for (SetCard *c in self.cards) {
                if (!c.isUnplayable && c.isSelected && c != card)
                    [playedCards addObject:c];
            }
        }
        card.selected = !card.isSelected;
    } else {
        NSLog(@"Unplayable card: impossible?");
    }
    return playedCards;
}
-(Card *)cardAtIndex:(NSUInteger) index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end

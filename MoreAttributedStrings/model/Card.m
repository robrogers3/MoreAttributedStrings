//
//  Card.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "Card.h"

@implementation Card
-(int)match:(NSArray *)otherCards
{
    int score;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents])
            score = 1;
    }
    return score;
}
@end

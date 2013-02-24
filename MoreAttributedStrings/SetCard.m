//
//  SetCard.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "SetCard.h"
@interface SetCard()
@end

@implementation SetCard
-(int) match:(NSArray *) otherCards
{
    int score = 0;
    if ([otherCards count] == 2) {
        SetCard *c2 = [otherCards objectAtIndex:0];
        SetCard *c3 = [otherCards objectAtIndex:1];
        int shapeMatch = ([self.shape integerValue] + [c2.shape integerValue] + [c3.shape integerValue]) % 3;
        int colorMatch = ([self.color integerValue] + [c2.color integerValue] + [c3.color integerValue]) % 3;
        int countMatch = ([self.count integerValue] + [c2.count integerValue] + [c3.count integerValue]) % 3;
        int fillMatch  = ([self.fill integerValue] + [c2.fill integerValue] + [c3.fill integerValue]) % 3;
        score = (shapeMatch + colorMatch + countMatch + fillMatch) == 0 ? 10 : 0;
    } else {
        NSLog(@"Setcard match: wrong number of cards passed %d", [otherCards count]);
    }
    return score;
}
-(NSDictionary *) properties {
    
    NSDictionary *p = @{@"shape":self.shape,@"color": self.color,@"count":self.count,@"fill":self.fill};
    return p;
}
-(void)setProperties: (NSDictionary *) props
{
    self.shape = props[@"shape"];
    self.color = props[@"color"];
    self.count = props[@"count"];
    self.fill = props[@"fill"];
    //self.properties = @{@"shape": shape, @"color": aColor, @"count": [NSNumber numberWithInt:num],
    //@"filled": [NSNumber numberWithInt:fill], @"isShaded": [NSNumber numberWithInt:shade]};
}
+(NSArray *) validShapes
{
    return @[@(TRIANGLE),@(SQUARE),@(CIRCLE)];
}
+(NSArray *) validColors
{
    return @[@(ORANGE),@(BLUE),@(GREEN)];
}
+(NSArray *) validFills
{
    return @[@(OPAQUE_FILL),@(NO_FILL),@(SHADED_FILL)];
}
+(NSArray *)validCounts
{
    return @[@(1),@(2),@(3)];
}

@end

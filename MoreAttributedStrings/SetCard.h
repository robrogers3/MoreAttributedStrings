//
//  SetCard.h
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/18/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

enum {TRIANGLE = 1, SQUARE, CIRCLE};
enum {ORANGE = 1, BLUE = 2 , GREEN = 3};
enum {NO_FILL = 1, OPAQUE_FILL, SHADED_FILL};

@interface SetCard : Card
@property (strong,nonatomic) NSNumber *shape;
@property (strong,nonatomic) NSNumber *count;
@property (strong,nonatomic) NSNumber *fill;
@property (strong,nonatomic) NSNumber *color;
@property (strong,nonatomic) NSDictionary *properties;
@property (nonatomic,getter=isSelected) int selected;
+(NSArray *) validShapes;
+(NSArray *) validColors;
+(NSArray *) validFills;
+(NSArray *) validCounts;
@end

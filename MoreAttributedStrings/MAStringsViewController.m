//
//  MAStringsViewController.m
//  MoreAttributedStrings
//
//  Created by Robert Rogers on 2/16/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "MAStringsViewController.h"
#import "SetCardGame.h"

@interface MAStringsViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPlayLabel;
@property (nonatomic) NSUInteger flipCount;
@property (strong,nonatomic) SetCardGame *game;
@end

@implementation MAStringsViewController {
    NSArray *playedCards;
    
}
-(SetCardGame *) game {
    if (!_game) {
        _game = [[SetCardGame alloc] initWithCardCount:[self.cardButtons count] usingDeck: [[SetCardDeck alloc]init]];
    }
    return _game;
}
-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}
-(UIColor *) determineColor: (int) color
{
    if (color == ORANGE)
        return [UIColor orangeColor];
    else if (color == BLUE)
        return [UIColor blueColor];
    else if (color == GREEN)
        return [UIColor greenColor];
    else
        return [UIColor redColor];
}
-(NSString *) determineShape: (NSNumber *) shape
{
    int i = [shape integerValue];
    switch (i) {
        case TRIANGLE: return @"▲";
            break;
        case SQUARE: return @"■";
            break;
        case CIRCLE: return @"●";
            break;
        default: return @"♡";//erroneous
            break;
    }
}
-(NSAttributedString *)makeTitleFromCard: (SetCard *) sc
{
    NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
    NSMutableString *s = [[NSMutableString alloc] init];
    NSString *shape = [self determineShape: sc.shape];
    for (int i = 0; i < [sc.count integerValue];i++)
        [s appendString:shape];
    UIColor *shapeColor = [self determineColor:[sc.color integerValue]];
    [attr setValue:[UIFont systemFontOfSize:(CGFloat) 17]forKey:NSFontAttributeName];
    if ([sc.fill integerValue] == OPAQUE_FILL) {
        [attr setValue:shapeColor forKey:NSForegroundColorAttributeName];
        [attr setValue: [NSNumber numberWithFloat:-7.0] forKey:NSStrokeWidthAttributeName];
        [attr setValue:shapeColor forKey:NSStrokeColorAttributeName];
    } else if (NO_FILL == [sc.fill integerValue])  {
        [attr setValue:shapeColor forKey:NSForegroundColorAttributeName];
        [attr setValue: [NSNumber numberWithFloat:7.0] forKey:NSStrokeWidthAttributeName];
        [attr setValue:shapeColor forKey:NSStrokeColorAttributeName];
    } else { //Shaded
        [attr setValue:[shapeColor colorWithAlphaComponent:0.5] forKey:NSForegroundColorAttributeName];
        [attr setValue: [NSNumber numberWithFloat:-10.0] forKey:NSStrokeWidthAttributeName];
        [attr setValue:shapeColor forKey:NSStrokeColorAttributeName];
    }
    NSAttributedString *as = [[NSAttributedString alloc] initWithString:s attributes:attr];
    return as;
}
-(NSMutableAttributedString *) getLastPlay
{
    NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
    [attr setValue:[UIFont systemFontOfSize:(CGFloat) 17]forKey:NSFontAttributeName];
    NSString *s, *t;
    NSMutableAttributedString *as;
    s = [NSString stringWithFormat:@"%u card%@ played ",[playedCards count], ([playedCards count] == 1) ? @"" : @"s"];
    as = [[NSMutableAttributedString alloc] initWithString:s attributes:attr];
    if (self.game.lastScore != 0) {
        for (SetCard *Card in playedCards) {
            [as appendAttributedString:[self makeTitleFromCard:Card]];
            [as appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        if (self.game.lastScore < 0) {
            t = [[NSString alloc]initWithFormat:@"- Mismatch!: %d point penalty", -1 * self.game.lastScore];
            [as appendAttributedString: [[NSAttributedString alloc] initWithString:t]];
        } else {
            t = [[NSString alloc]initWithFormat:@"- Matched! %d point score", self.game.lastScore];
            [as appendAttributedString: [[NSAttributedString alloc] initWithString:t]];
        }
    } else {
        if ([playedCards count]) {
            for (SetCard *sc in playedCards) {
                [as appendAttributedString:[self makeTitleFromCard:sc]];
                [as appendAttributedString:[[NSAttributedString alloc] initWithString:@""]];
            }
        } else {
            [as appendAttributedString:[[NSAttributedString alloc] initWithString:@" - select a card"]];
        }
        
    }
    return as;
}
-(void) updateUI
{
    UIImage *cardSelectedImage = [UIImage imageNamed:@"gradient12x.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(6,6,6,6);
    for (UIButton *button in self.cardButtons) {
        SetCard *Card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:button]];
        [button setAttributedTitle:[self makeTitleFromCard:Card] forState:UIControlStateNormal];
        [button setBackgroundImage:cardSelectedImage forState:UIControlStateSelected];
        [button setImageEdgeInsets:insets];
        button.selected = Card.isSelected;
        button.enabled = !Card.isUnplayable;
        button.alpha = Card.isUnplayable ? 0.1 : Card.isSelected ? 1.0 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.lastPlayLabel.attributedText = [self getLastPlay];
    self.lastPlayLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)setFlipCount:(NSUInteger)flipCount {
    _flipCount = flipCount;
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender {
    playedCards = [self.game selectCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  CustomSegment.m
//  NHSNottingham
//
//  Created by Khoa Le on 5/13/14.
//  Copyright (c) 2014 Khoa Le. All rights reserved.
//

#import "CustomSegment.h"
#import "UIImage+DrawColor.h"

static float widthALine;
static float spaceSeparator = 5.0f;

@implementation CustomSegment

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self apperance];
}

- (id)init {
    self = [super init];
    if (self) {
        [self apperance];
    }
    return self;
}

#pragma mark - apperance
- (void)apperance {
    //	[self setTitleTextAttributes:@{ NSFontAttributeName:self.FFont,
    //	                                NSForegroundColorAttributeName:self.FColor,
    //	                                UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
    //	                                UITextAttributeTextShadowColor: [UIColor clearColor] }
    //	                    forState:UIControlStateNormal];

    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.FFont, NSFontAttributeName, self.FColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];


    NSDictionary *highlightedAttributes = @{ NSForegroundColorAttributeName: self.FSelectionTextColor };
    [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];

    [self CustomBackground];


    _selectLine = [[UIImageView alloc] initWithFrame:CGRectMake(1.0, self.Fheight - self.FWidthSelectLine, CGRectGetWidth(self.bounds) / self.numberOfSegments - 2, self.FWidthSelectLine)];
    _selectLine.backgroundColor = [UIColor colorWithRed:59.0/255.0 green:167.0/255.0 blue:46.0/255.0 alpha:1.0];
    [self addSubview:_selectLine];


    [self addTarget:self action:@selector(ReFrameSelectLineWithIndex:) forControlEvents:UIControlEventValueChanged];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    [self drawUnderLineWithColor:self.FLineColor];

    self.selectLine.frame = ({
        CGRect frame = self.selectLine.frame;
        frame.size.width = rect.size.width/self.numberOfSegments;
        frame;
    });
    [self drawSeparatorWithColor:self.FLineColor];
}

#pragma mark - draw Under line
- (void)drawUnderLineWithColor:(UIColor *)color {
    widthALine = CGRectGetWidth(self.bounds) / self.numberOfSegments;

    for (int i = 0; i < self.numberOfSegments; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        CGContextSetLineWidth(context, self.FWidthUnderLine);
        CGContextMoveToPoint(context, i * widthALine + 1, CGRectGetHeight(self.bounds));
        CGContextAddLineToPoint(context, (i + 1) * widthALine - 1, CGRectGetHeight(self.bounds));
        CGContextDrawPath(context, kCGPathStroke);
    }
}

#pragma mark - draw Separator line
- (void)drawSeparatorWithColor:(UIColor *)color {
    for (int i = 1; i < self.numberOfSegments; i++) {
        CGPoint pointMoveFrom = CGPointMake(i * (CGRectGetWidth(self.bounds) / self.numberOfSegments), spaceSeparator);
        CGPoint pointmoveTo = CGPointMake(i * (CGRectGetWidth(self.bounds) / self.numberOfSegments), CGRectGetHeight(self.bounds) - spaceSeparator);

        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        CGContextSetLineWidth(context, self.FWidthSeparator);
        CGContextMoveToPoint(context, pointMoveFrom.x, pointMoveFrom.y);
        CGContextAddLineToPoint(context, pointmoveTo.x, pointmoveTo.y);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

# pragma mark - Background Image
- (void)CustomBackground {
    [self setBackgroundImage:[UIImage DrawImageWithSize:CGSizeMake(10, self.Fheight) Color:@[self.FBackgroundColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [self setBackgroundImage:[UIImage DrawImageWithSize:CGSizeMake(10, self.Fheight) Color:@[self.FSelectColor]]
                    forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];

    [self setDividerImage:[UIImage DrawImageWithSize:CGSizeMake(1, self.Fheight) Color:@[self.FSelectColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

#pragma mark - Action Change Line Select
- (void)ReFrameSelectLineWithIndex:(UISegmentedControl *)segment {
    widthALine = CGRectGetWidth(self.bounds) / self.numberOfSegments;

    long index = segment.selectedSegmentIndex;
    CGRect rectSelectLine = _selectLine.frame;
    rectSelectLine.origin.x = index * widthALine + 1;
    _selectLine.frame = rectSelectLine;
}

#pragma mark - Acessors

- (UIColor *)FColor {
    return _FColor ? : [UIColor blackColor];
}

- (UIFont *)FFont {
    return _FFont ? : [UIFont boldSystemFontOfSize:10.0];
}

- (float)Fheight {
    return _Fheight ? : 30;
}

- (UIColor *)FLineColor {
    return _FLineColor ? : [UIColor blackColor];
}

- (float)FWidthUnderLine {
    return _FWidthUnderLine ? : 2.0;
}

- (float)FWidthSeparator {
    return _FWidthSeparator ? : 1.0;
}

- (float)FWidthSelectLine {
    return _FWidthSelectLine ? : 5.0;
}

- (UIColor *)FSelectColor {
    return _FSelectColor ? : [UIColor clearColor];
}

- (UIColor *)FBackgroundColor {
    return _FBackgroundColor ? : [UIColor clearColor];
}

- (UIColor *)FSelectionTextColor {
    return _FSelectionTextColor ? : [UIColor blackColor];
}

@end

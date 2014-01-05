//
//  P2MSDrawingView.m
//  SimpleMazeGame
//
//  Created by PYAE PHYO MYINT SOE on 5/1/14.
//  Copyright (c) 2014 PYAE PHYO MYINT SOE. All rights reserved.
//

#import "P2MSDrawingView.h"

@implementation P2MSDrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    if (_points.count > 1) {
        CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(c, red);
        CGContextSetLineWidth(c, 5);
        CGContextBeginPath(c);
        int i = 0;
        for (NSValue *curPoint in _points) {
            CGPoint curP = [curPoint CGPointValue];
            if (!i++) {
                CGContextMoveToPoint(c, curP.x , curP.y);
            }else
                CGContextAddLineToPoint(c, curP.x, curP.y);
        }
        CGContextStrokePath(c);
    }
    CGContextRestoreGState(c);
}


@end

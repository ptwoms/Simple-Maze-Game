//
//  P2MSMazeViewController.m
//  SimpleMazeGame
//
//  Created by PYAE PHYO MYINT SOE on 5/1/14.
//  Copyright (c) 2014 PYAE PHYO MYINT SOE. All rights reserved.
//

#import "P2MSMazeViewController.h"
#import "P2MSDrawingView.h"

typedef enum {
    MOVE_NONE = 0,
    LEFT_OPEN = 1,
    RIGHT_OPEN = 2,
    TOP_OPEN = 4,
    BOTTOM_OPEN = 8
}MOVE_POS;


@interface P2MSMazeViewController (){
    NSArray *board;
    P2MSDrawingView *drawingView;
    NSMutableIndexSet *indexes;
    NSInteger gameEndIndex, gameStartIndex, gameCurrentIndex;
    CGFloat cellWidth, cellHeight;
    NSUInteger boardWidth, boardHeight;
}

@end

@implementation P2MSMazeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    indexes = [[NSMutableIndexSet alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
	
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 455, 455)];
    [imageView setImage:[UIImage imageNamed:@"maze"]];
    imageView.center = self.view.center;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    imageView.userInteractionEnabled = YES;
    
    drawingView = [[P2MSDrawingView alloc]initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    [imageView addSubview:drawingView];
    
    boardWidth = 10;
    boardHeight = 10;

    cellWidth = 455/boardWidth;
    cellHeight = 455/boardHeight;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imagePannedOnly:)];
    [drawingView addGestureRecognizer:panGesture];
    
    [self.view addSubview:imageView];
    [self initBoard];
    [self initGame];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 100, 45);
    [button setTitle:@"Reset" forState:UIControlStateNormal];
    button.center = CGPointMake(self.view.center.x, 50);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [button addTarget:self action:@selector(resetGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)initBoard{
    board = [NSArray arrayWithObjects:
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN],
             
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN],
             
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|LEFT_OPEN],
             
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN],
             
             [NSNumber numberWithInteger:TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|BOTTOM_OPEN],
             
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|LEFT_OPEN],
             
             [NSNumber numberWithInteger:TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|BOTTOM_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|TOP_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN],
             
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|BOTTOM_OPEN],
             
             [NSNumber numberWithInteger:TOP_OPEN],
             [NSNumber numberWithInteger:BOTTOM_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             [NSNumber numberWithInteger:TOP_OPEN|RIGHT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:RIGHT_OPEN|LEFT_OPEN],
             [NSNumber numberWithInteger:LEFT_OPEN|TOP_OPEN],
             nil];
}

- (void)initGame{
    gameEndIndex = 91;
    gameStartIndex = 5;
    gameCurrentIndex = 5;
    if (drawingView.points) {
        [drawingView.points removeAllObjects];
    }else{
        drawingView.points = [NSMutableArray array];
    }
    if (indexes) {
        [indexes removeAllIndexes];
    }else{
        indexes = [NSMutableIndexSet indexSet];
    }
    [drawingView.points addObject:[NSValue valueWithCGPoint:CGPointMake(gameStartIndex*cellWidth + (cellWidth/2), 0)]];
    [drawingView.points addObject:[NSValue valueWithCGPoint:CGPointMake(gameStartIndex*cellWidth + (cellWidth/2), cellHeight/2)]];
    [drawingView setNeedsDisplay];
}

- (IBAction)resetGame:(id)sender{
    [self initGame];
}

- (void)imagePannedOnly:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint positioninside = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    NSInteger indexX = floorf((positioninside.x)/cellWidth);
    NSInteger indexY = floorf((positioninside.y)/cellHeight);
    NSInteger newIndex = indexX + (indexY*boardWidth);

    if (gameCurrentIndex == newIndex || [indexes containsIndex:newIndex] || newIndex >= board.count) {
    }else if (
              //left
              (newIndex == gameCurrentIndex-1 && ([[board objectAtIndex:gameCurrentIndex]integerValue] & LEFT_OPEN)) ||
              //bottom
              (newIndex == gameCurrentIndex+boardWidth && ([[board objectAtIndex:gameCurrentIndex]integerValue] & BOTTOM_OPEN)) ||
              //top
              (newIndex == gameCurrentIndex-boardWidth && ([[board objectAtIndex:gameCurrentIndex]integerValue] & TOP_OPEN)) ||
              //right
              (newIndex == gameCurrentIndex+1 && ([[board objectAtIndex:gameCurrentIndex]integerValue] & RIGHT_OPEN))
              )
    {
        gameCurrentIndex = newIndex;
        [drawingView.points addObject:[NSValue valueWithCGPoint:CGPointMake((indexX*cellWidth)+(cellWidth/2), (indexY*cellHeight)+(cellHeight/2))]];
        [indexes addIndex:gameCurrentIndex];
        [drawingView setNeedsDisplay];

    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        if (gameCurrentIndex == gameEndIndex) {
            NSInteger endY = (NSInteger)floorf((float)gameEndIndex/(float)boardWidth);
            NSInteger endX = gameEndIndex%boardWidth;
            [drawingView.points addObject:[NSValue valueWithCGPoint:CGPointMake(cellWidth*endX+(cellWidth/2), cellHeight*endY+cellHeight)]];
            [drawingView setNeedsDisplay];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Congratulations" message:@"You have won!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else if(![self gameCanMoveFurther]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Try Again" message:@"Cannot go further!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [self initGame];
        }
    }
}

- (BOOL)gameCanMoveFurther{
    NSInteger curInt = [[board objectAtIndex:gameCurrentIndex]integerValue];
    return ((curInt & LEFT_OPEN && ![indexes containsIndex:gameCurrentIndex-1]) ||
        (curInt & RIGHT_OPEN && ![indexes containsIndex:gameCurrentIndex+1]) ||
        (curInt & TOP_OPEN && ![indexes containsIndex:gameCurrentIndex-boardWidth]) ||
        (curInt & BOTTOM_OPEN && ![indexes containsIndex:gameCurrentIndex+boardWidth])
        );
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

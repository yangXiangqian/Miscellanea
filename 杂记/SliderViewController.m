//
//  SliderViewController.m
//  杂记
//
//  Created by DC019 on 15/11/17.
//  Copyright © 2015年 木易. All rights reserved.
//

#import "SliderViewController.h"


@implementation SliderViewController
{
    UIViewController  *_currentMainController;
    UIPanGestureRecognizer *_panGestureReconginzer;
    BOOL sideBarShowing;
    CGFloat currentTranslate;
}
static SliderViewController *rootViewCon;
const int ContentOffset=270;
const int ContentMinOffset=40;
const float MoveAnimationDuration = 0.3;

-(void)viewDidLoad{
    [super viewDidLoad];
    if (rootViewCon) {
        rootViewCon = nil;
    }
    rootViewCon = self;
    sideBarShowing = NO;
    currentTranslate = 0;
 
    self.administrationViewController = [[AdministrationViewController alloc] init];
    self.showContentViewController = [[ShowContentViewController alloc] init];
    self.contentView = self.showContentViewController.view;
    
    //self.administrationViewController.delegate = self;
    self.BackView = self.administrationViewController.view;
    [self addChildViewController:_administrationViewController];
    _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
    [self.contentView addGestureRecognizer:_panGestureReconginzer];
    [self.view addSubview:self.BackView];
    [self.view addSubview:self.contentView];
}

- (void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{
    
    if (panGestureReconginzer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat translation = [panGestureReconginzer translationInView:self.contentView].x;
        if (translation+currentTranslate < 0) {
            return;
        }
        self.contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
        UIView *view ;
        if (translation+currentTranslate>0)
        {
            view = self.administrationViewController.view;
            [self.BackView bringSubviewToFront:view];
        }
        
        
    } else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
        currentTranslate = self.contentView.transform.tx;
        if (!sideBarShowing) {
            if (fabs(currentTranslate)<ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }
        }else
        {
            if (fabs(currentTranslate)<ContentOffset-ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                
            }else
            {
                
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                
            }
        }
        
        
    }
    
    
}
- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
        switch (direction) {
            case SideBarShowDirectionNone:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            default:
                break;
        }
    };
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.BackView.userInteractionEnabled = YES;
        if (direction == SideBarShowDirectionNone) {
            sideBarShowing = NO;
            
            
        }else
        {
            sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
    };
    self.contentView.userInteractionEnabled = NO;
    self.BackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}


@end

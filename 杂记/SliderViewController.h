//
//  SliderViewController.h
//  杂记
//
//  Created by DC019 on 15/11/17.
//  Copyright © 2015年 木易. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdministrationViewController.h"
typedef enum _SideBarShowDirection
{
    SideBarShowDirectionNone = 0,
    SideBarShowDirectionLeft = 1
}SideBarShowDirection;
@interface SliderViewController : UIViewController
@property(nonatomic,strong)AdministrationViewController * administrationViewController;
@property(nonatomic,strong)ShowContentViewController * showContentViewController;
@property (strong,nonatomic) UIView *contentView;
@property (strong,nonatomic) UIView *BackView;
@end

//
//  MenuVC.m
//  FileMG
//
//  Created by midoks on 2017/11/12.
//  Copyright © 2017年 midoks. All rights reserved.
//

#import "MenuVC.h"

#import "FileBrowserVC.h"
#import "TransferVC.h"
#import "SettingVC.h"

@interface MenuVC ()

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", NSHomeDirectory());
    [self setTabBars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setTabBars {
    
    
    FileBrowserVC *bookshelf = [[FileBrowserVC alloc] init];
    UINavigationController *bookshelfNav = [[UINavigationController alloc] initWithRootViewController:bookshelf];
//    UITabBarItem *mainIcon = [[UITabBarItem alloc] initWithTitle:@"书架" image:[UIImage imageNamed:@"mb_bookshelf"] tag:0];
    bookshelfNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:3];
    bookshelfNav.title = @"文件管理";
    
    
    TransferVC *search = [[TransferVC alloc] init];
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:search];
//    UITabBarItem *fileIcon = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"md_rearch"] tag:1];
    searchNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:3];
    
    SettingVC *bookSetting = [[SettingVC alloc] init];
    UINavigationController *bookSettingNav = [[UINavigationController alloc] initWithRootViewController:bookSetting];
//    UITabBarItem *novelIcon = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"md_setting"] tag:3];
    bookSettingNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:3];
    
    NSArray *navView = [[NSArray alloc] initWithObjects:bookshelfNav, searchNav, bookSettingNav,nil];
    
    //隐藏文字
//    for (int item = 0; item < [v count]; item++) {
//        UINavigationController *uiNav = [v objectAtIndex:item];
//        [uiNav.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
//        [uiNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, 12)];
//    }
    [self setViewControllers:navView animated:NO];
    
    
//    self.view.backgroundColor = [UIColor redColor];
//    UIView *t = [[UIView alloc] initWithFrame:self.view.frame];
//    t.backgroundColor = [UIColor redColor];
//    [self.view addSubview:t];
    
}

@end

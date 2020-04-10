//
//  FileBrowserVC.m
//  FileMG
//
//  Created by midoks on 2017/11/12.
//  Copyright © 2017年 midoks. All rights reserved.
//

#import "FileBrowserVC.h"

@interface FileBrowserVC () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation FileBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文件浏览";
//    [self.navigationController.navigationBar setTranslucent:NO];

    
    [self initTableView];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    header.backgroundColor = [UIColor clearColor];
    [self.view addSubview:header];
//    header.alpha = 1;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    cell.imageView.image = [UIImage imageNamed:@"md_s_booksetting"];
    cell.textLabel.text = @"显示隐藏文件";

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

@end

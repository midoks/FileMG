//
//  SettingVC.m
//  FileMG
//
//  Created by midoks on 2017/11/12.
//  Copyright © 2017年 midoks. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];

     [self initTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    if(indexPath.section == 0){
        
        if (indexPath.row == 0){
            cell.imageView.image = [UIImage imageNamed:@"md_s_booksetting"];
            cell.textLabel.text = @"显示隐藏文件";
        }
        
    } else if(indexPath.section == 1){
        
        if (indexPath.row == 0){
            cell.imageView.image = [UIImage imageNamed:@"md_s_zan"];//md_s_zan
            cell.textLabel.text = @"好评支持一下";
        } else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"md_s_advise"];
            cell.textLabel.text = @"APP意见反馈";
        }
        
       
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"md_s_about"];
        cell.textLabel.text = @"关于";
    }
    
    //cell.textLabel.text = [indexData objectForKey:@"bookname"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];

    
}


@end

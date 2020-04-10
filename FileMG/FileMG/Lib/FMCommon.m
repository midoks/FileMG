//
//  FMCommon.m
//  FileMG
//
//  Created by midoks on 2017/11/15.
//  Copyright © 2017年 midoks. All rights reserved.
//

#import "FMCommon.h"

#import "MBProgressHUD.h"

@implementation FMCommon

+(void)toast:(NSString *)msg view:(UIView *)view afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

@end

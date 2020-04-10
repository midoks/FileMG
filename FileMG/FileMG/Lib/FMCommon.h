//
//  FMCommon.h
//  FileMG
//
//  Created by midoks on 2017/11/15.
//  Copyright © 2017年 midoks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FMCommon : NSObject

+(void)toast:(NSString *)msg view:(UIView *)view afterDelay:(NSTimeInterval)delay;

@end

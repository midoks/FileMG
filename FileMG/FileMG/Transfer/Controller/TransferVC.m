//
//  TransferVC.m
//  FileMG
//
//  Created by midoks on 2017/11/12.
//  Copyright © 2017年 midoks. All rights reserved.
//

#import "TransferVC.h"



#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "GCDWebUploader.h"
#import "RealReachability.h"
#import "LocalConnection.h"

#import "FMCommon.h"

@interface TransferVC ()

@property (nonatomic, strong) GCDWebServer  *webServer;
@property (nonatomic, strong) GCDWebUploader *webUploader;

@property (nonatomic, strong) UIImageView   *wifiImage;
@property (nonatomic, strong) UILabel       *wifiAddr;
@property (nonatomic, strong) UILabel       *wifiRead;
@property (nonatomic, strong) UILabel       *wifiNotice;
@property (nonatomic, strong) UISwitch      *wifiStatus;

@property (nonatomic, assign) BOOL          isWifi;

@property (nonatomic, strong) UILabel       *notWifi;


@end

@implementation TransferVC

-(void)viewWillAppear:(BOOL)animated {
    //GLobalRealReachability.hostForPing = @"www.baidu.com";
    [GLobalRealReachability startNotifier];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [GLobalRealReachability stopNotifier];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self setTitle:@"传输"];
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    
    
    [self initWifiView];
    _wifiImage.hidden = NO;
    _wifiRead.hidden = NO;
    _wifiAddr.hidden = NO;
    _wifiStatus.hidden = NO;
    _wifiNotice.hidden = NO;
    
    
    [self initNotWifiView];
    _notWifi.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(localConnectionInitialized:)
                                                 name:kLocalConnectionInitializedNotification
                                               object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)localConnectionInitialized:(NSNotification *)notification
{
    LocalConnection *lc = (LocalConnection *)notification.object;
    LocalConnectionStatus status = [lc currentLocalConnectionStatus];

    if (LC_WiFi == status){
        
        if([_webUploader isRunning]){
            _wifiStatus.on = YES;
            _wifiImage.image = [UIImage imageNamed:@"wifi_open"];
            
            [_webUploader stop];
            [_webUploader start];
            
        } else {
            _wifiStatus.on = NO;
            _wifiImage.image = [UIImage imageNamed:@"wifi_close"];
        }
        _wifiAddr.text = _webUploader.serverURL.absoluteString;
        
        
        _notWifi.hidden = YES;
        
        _wifiImage.hidden = NO;
        _wifiRead.hidden = NO;
        _wifiAddr.hidden = NO;
        _wifiStatus.hidden = NO;
        _wifiNotice.hidden = NO;
        
    } else {
        _notWifi.hidden = NO;

        _wifiImage.hidden = YES;
        _wifiRead.hidden = YES;
        _wifiAddr.hidden = YES;
        _wifiStatus.hidden = YES;
        _wifiNotice.hidden = YES;
    }
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    
    if (RealStatusViaWiFi == status){
    
        if([_webUploader isRunning]){
            _wifiStatus.on = YES;
            _wifiImage.image = [UIImage imageNamed:@"wifi_open"];
        } else {
            _wifiStatus.on = NO;
            _wifiImage.image = [UIImage imageNamed:@"wifi_close"];
        }
        _wifiAddr.text = _webUploader.serverURL.absoluteString;
        
        _notWifi.hidden = YES;
        
        _wifiImage.hidden = NO;
        _wifiRead.hidden = NO;
        _wifiAddr.hidden = NO;
        _wifiStatus.hidden = NO;
        _wifiNotice.hidden = NO;
        
    } else {
        _notWifi.hidden = NO;
        
        _wifiImage.hidden = YES;
        _wifiRead.hidden = YES;
        _wifiAddr.hidden = YES;
        _wifiStatus.hidden = YES;
        _wifiNotice.hidden = YES;
        
        [FMCommon toast:@"请将手机和电脑连到同一WIFI" view:self.view afterDelay:3.0];
    }
    
}

-(void)initNotWifiView {
    
    _notWifi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    _notWifi.center = self.view.center;
    _notWifi.text = @"无线传输不可使用";
    _notWifi.textColor = [UIColor grayColor];
    _notWifi.textAlignment = NSTextAlignmentCenter;
    _notWifi.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_notWifi];
}

-(void)initWifiView {
    
    _wifiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi_open"]];
    
    _wifiImage.frame = CGRectMake((self.view.frame.size.width - 100)/2, 80, 100, 100);
    [self.view addSubview:_wifiImage];
    
    _wifiRead = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280)/2, _wifiImage.frame.origin.y + 100 + 20, 280, 60)];
    _wifiRead.textColor = [UIColor grayColor];
    _wifiRead.textAlignment = NSTextAlignmentCenter;
    _wifiRead.lineBreakMode = NSLineBreakByCharWrapping;
    _wifiRead.numberOfLines = 0;
    _wifiRead.font = [UIFont systemFontOfSize:18];
    _wifiRead.text = @"确保电脑和手机已经连接同一WIFI,在电脑浏览器地址栏输入:";
    [self.view addSubview:_wifiRead];
    
    _wifiAddr = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280)/2, _wifiRead.frame.origin.y + 60, 280, 30)];
    _wifiAddr.text = @"等到中...";
    _wifiAddr.font = [UIFont systemFontOfSize:18];
    _wifiAddr.textAlignment = NSTextAlignmentCenter;
    _wifiAddr.textColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:_wifiAddr];
    
    _wifiStatus = [[UISwitch alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 51)/2, _wifiAddr.frame.origin.y + 100, 51, 31)];
    _wifiStatus.on = YES;
    [_wifiStatus addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_wifiStatus];
    
    _wifiNotice = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 220)/2, _wifiStatus.frame.origin.y + 60, 220, 20)];
    _wifiNotice.text = @"⚠️关闭App或锁屏会停止传输";
    _wifiNotice.font = [UIFont systemFontOfSize:16];
    _wifiNotice.textAlignment = NSTextAlignmentCenter;
    _wifiNotice.textColor = [UIColor grayColor];
    [self.view addSubview:_wifiNotice];
}

- (void)switchAction:(id)sender {
    
    if (_wifiStatus.on){
        _wifiStatus.on = YES;
        
        if (![_webUploader isRunning]) {
            [_webUploader start];
        }
        
        _wifiAddr.text = _webUploader.serverURL.absoluteString;
        [FMCommon toast:@"启动成功" view:self.view afterDelay:1.0];
    } else {
        _wifiStatus.on = NO;
        
        if ([_webUploader isRunning]) {
            [_webUploader stop];
        }
        
        [FMCommon toast:@"停止成功" view:self.view afterDelay:1.0];
    }
    
    if (_wifiStatus.on) {
        _wifiImage.image = [UIImage imageNamed:@"wifi_open"];
    } else {
        _wifiImage.image = [UIImage imageNamed:@"wifi_close"];
    }

}

@end

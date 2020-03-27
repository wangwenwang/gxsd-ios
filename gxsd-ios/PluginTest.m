//
//  PluginTest.m
//  HBuilder-Hello
//
//  Created by Mac Pro on 14-9-3.
//  Copyright (c) 2014年 DCloud. All rights reserved.
//

#import "PluginTest.h"
#import "PDRCoreAppFrame.h"
//#import "H5WEEngineExport.h"
#import "PDRToolSystemEx.h"
// 扩展插件中需要引入需要的系统库
#import <LocalAuthentication/LocalAuthentication.h>

@implementation PGPluginTest



#pragma mark 这个方法在使用WebApp方式集成时触发，WebView集成方式不触发

/*
 * WebApp启动时触发
 * 需要在PandoraApi.bundle/feature.plist/注册插件里添加autostart值为true，global项的值设置为true
 */
- (void) onAppStarted:(NSDictionary*)options{
   
    NSLog(@"5+ WebApp启动时触发");
    // 可以在这个方法里向Core注册扩展插件的JS
    
}

// 监听基座事件事件
// 应用退出时触发
- (void) onAppTerminate{
    //
    NSLog(@"APPDelegate applicationWillTerminate 事件触发时触发");
}

// 应用进入后台时触发
- (void) onAppEnterBackground{
    //
    NSLog(@"APPDelegate applicationDidEnterBackground 事件触发时触发");
}

// 应用进入前天时触发
- (void) onAppEnterForeground{
    //
    NSLog(@"APPDelegate applicationWillEnterForeground 事件触发时触发");
}

#pragma mark 以下为插件方法，由JS触发， WebView集成和WebApp集成都可以触发

// 获取用户信息
- (void)PluginPrintIosFunction:(PGMethod*)commands{
    
    if(commands){
        NSString *user_info = [commands.arguments objectAtIndex: 1];
        [[NSUserDefaults standardUserDefaults] setObject:user_info forKey:@"w_UserInfo"];
    }
}

// 获取用户信息
- (void)PluginGetUserFunction:(PGMethod*)commands{
    
    if(commands){
        NSString *cbId = [commands.arguments objectAtIndex: 0];
        NSString *user_info = [[NSUserDefaults standardUserDefaults] objectForKey:@"w_UserInfo"];
        NSArray *arr = [NSArray arrayWithObject:user_info];
        PDRPluginResult *result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsArray: arr];
        [self toCallback:cbId withReslut:[result toJSONString]];
    }
}

@end

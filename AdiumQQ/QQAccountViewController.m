//
//  QQAccountViewController.m
//  AdiumQQ
//
//  Created by William Orr on 11/30/11.
//  Copyright (c) 2011 William Orr. All rights reserved.
//

#import "QQAccountViewController.h"

#import "QQAccount.h"

#include <libpurple/account.h>

@interface QQAccountViewController ()
- (NSMenu*) serverMenu;
@end

@implementation QQAccountViewController

- (NSString *)nibName {
    return @"QQAccountView";
}

- (void) configureForAccount:(AIAccount *)inAccount {
    [super configureForAccount:inAccount];
    
    [checkBox_tcpConnect setState:[[account preferenceForKey:KEY_QQ_TCP_CONNECT group:GROUP_ACCOUNT_STATUS] boolValue]];

    [popUp_serverList setMenu:[self serverMenu]];
    [popUp_serverList selectItemWithTitle:[account preferenceForKey:KEY_QQ_CONNECT_HOST group:GROUP_ACCOUNT_STATUS]];
    
    [textField_connectPort setStringValue:[account preferenceForKey:KEY_QQ_CONNECT_PORT group:GROUP_ACCOUNT_STATUS]];
}

- (void) saveConfiguration {
    [super saveConfiguration];
    PurpleAccount* purpAcc = NULL;
    
    if ([account respondsToSelector:@selector(purpleAccount)]) {
        purpAcc = [account purpleAccount];
    }

    BOOL tcp = [checkBox_tcpConnect state];
    [account setPreference:[NSNumber numberWithInt:tcp] forKey:KEY_QQ_TCP_CONNECT group:GROUP_ACCOUNT_STATUS];
    
    purple_account_set_bool(purpAcc, 
                            [KEY_QQ_TCP_CONNECT UTF8String], 
                            tcp);

    NSString* server = [popUp_serverList titleOfSelectedItem];
    [account setPreference:server forKey:KEY_CONNECT_HOST group:GROUP_ACCOUNT_STATUS];
    
    NSString* port = [textField_connectPort stringValue];
    [account setPreference:[NSNumber numberWithInt:[port intValue]] forKey:KEY_CONNECT_PORT group:GROUP_ACCOUNT_STATUS];
    
    // Let's send over the preference information to libqq-pidgin
    server = [[server stringByAppendingString:@":"] stringByAppendingString:port];
    purple_account_set_string(purpAcc, 
                               [KEY_QQ_CONNECT_HOST UTF8String], 
                               [server UTF8String]);
}

- (void) changedPreference:(id)sender {
    if ([checkBox_tcpConnect isEqual:sender])
        [popUp_serverList setMenu:[self serverMenu]];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [popUp_serverList setMenu:[self serverMenu]];
}

- (NSMenu*) serverMenu {
    NSMenu* serverMenu = [[NSMenu allocWithZone:[NSMenu zone]] init];
    NSArray* serverArray;
    NSMenuItem* serverMenuItem;
    NSEnumerator* enumer;
    NSString* item;
    
    if (![checkBox_tcpConnect state]) {
        serverArray = [[[NSArray alloc] initWithObjects:                   
                        @"sz.tencent.com",
                        @"sz2.tencent.com",
                        @"sz3.tencent.com",
                        @"sz4.tencent.com",
                        @"sz5.tencent.com",
                        @"sz6.tencent.com",
                        @"sz7.tencent.com",
                        @"sz8.tencent.com",
                        @"sz9.tencent.com", 
                        nil] autorelease];
    } else {
        serverArray = [[[NSArray alloc] initWithObjects:
                        @"tcpconn.tencent.com",
                        @"tcpconn2.tencent.com",
                        @"tcpconn3.tencent.com",
                        @"tcpconn4.tencent.com",
                        @"tcpconn5.tencent.com",
                        @"tcpconn6.tencent.com", 
                        nil] autorelease];
    }
    
    enumer = [serverArray objectEnumerator];
    while (item = [enumer nextObject]) {
        serverMenuItem = [[[NSMenuItem allocWithZone:[NSMenu zone]] initWithTitle:item action:nil keyEquivalent:@""] autorelease];
        [serverMenu addItem:serverMenuItem];
    }
    
    return [serverMenu autorelease];
}

@end

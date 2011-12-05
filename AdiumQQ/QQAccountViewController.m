//
//  QQAccountViewController.m
//  AdiumQQ
//
//  Created by William Orr on 11/30/11.
//  Copyright (c) 2011 William Orr. All rights reserved.
//

#import "QQAccountViewController.h"

#import "QQAccount.h"

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
}

- (void) saveConfiguration {
    [super saveConfiguration];
    
    [account setPreference:[NSNumber numberWithInteger:[checkBox_tcpConnect state]]forKey:KEY_QQ_TCP_CONNECT group:GROUP_ACCOUNT_STATUS];


    [account setPreference:[popUp_serverList titleOfSelectedItem] forKey:KEY_QQ_CONNECT_HOST group:GROUP_ACCOUNT_STATUS];
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

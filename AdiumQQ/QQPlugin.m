//
//  QQPlugin.m
//  libqq-adium
//
//  Created by William Orr on 11/19/11.
//  Copyright (c) 2011 William Orr. All rights reserved.
//

#import "QQPlugin.h"
#import "QQService.h" 
#import <glib.h>

extern gboolean purple_init_qq_plugin(void);
@implementation QQPlugin

- (void) installPlugin {
    [QQService registerService];
    purple_init_qq_plugin();
}

- (void) uninstallPlugin {
}

- (void) installLibpurplePlugin {
}

- (void) loadLibpurplePlugin {
}

@end

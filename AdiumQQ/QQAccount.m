//
//  QQAccount.m
//  libqq-adium
//
//  Created by William Orr on 11/19/11.
//  Copyright (c) William Orr. All rights reserved.
//

#import "QQAccount.h"

@implementation QQAccount

- (const char*) protocolPlugin {
    return "prpl-qq";
}

- (void) configurePurpleAccount {
    [super configurePurpleAccount];
}

- (BOOL) canSendFolders {
    return NO;
}

- (void) beginSendOfFileTransfer:(ESFileTransfer *)fileTransfer {
    return [super _beginSendOfFileTransfer:fileTransfer];
}

- (void) acceptFileTransferRequest:(ESFileTransfer *)fileTransfer {
    return [super acceptFileTransferRequest:fileTransfer];
}

- (void) rejectFileReceiveRequest:(ESFileTransfer *)fileTransfer {
    return [super rejectFileReceiveRequest:fileTransfer];
}

- (void) cancelFileTransfer:(ESFileTransfer *)fileTransfer {
    return [super cancelFileTransfer:fileTransfer];
}

@end

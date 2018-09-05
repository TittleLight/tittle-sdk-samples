//
//  SocketConnection.h
//  TittleFramework
//
//  Created by Jackie on 3/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface SocketConnection : NSObject {
    
    GCDAsyncSocket *socket;
    
    NSDate *socketCreateDate;
    
    NSString *connectIP;
    int connectPort;
}

- (void)connect:(id)controller ip: (NSString *)ip port: (int)port;
- (void)disconnect;

- (void)writeData:(NSData *) data withTag:(long)tag withController:(id)controller;

@end

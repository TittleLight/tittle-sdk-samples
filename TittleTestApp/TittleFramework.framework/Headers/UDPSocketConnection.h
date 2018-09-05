//
//  UDPSocketConnection.h
//  TittleFramework
//
//  Created by Jackie on 3/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "constants.h"

@interface UDPSocketConnection : NSObject {
    GCDAsyncUdpSocket *udpSocket;
}

- (void)initSocket:(id)controller;

-(void)writeData:(NSData *)data host:(NSString *)host port:(uint16_t)port tag:(int)tag controller:(id)controller;
-(void) close;
@end

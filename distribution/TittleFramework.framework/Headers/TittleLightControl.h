//
//  TittleLightControl.h
//  TittleFramework
//
//  Created by Jackie on 30/8/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"
#import "Utils.h"
#import "SocketConnection.h"
#import "UDPSocketConnection.h"
#import "ByteDataCreator.h"
#import "GCDAsyncSocket.h"
#import "TittleData.h"

@protocol TittleLightControlDelegate <NSObject>
@optional
- (void) receivedNewTittle: (TittleData *)tittle;
- (void) socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port;
- (void) socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err;
- (void) didReceivedResponsedFromLightMode: (int)ackCode;
- (void) didReceivedResponsedFromStandardConfigMode: (int)ackCode;
- (void) standardConfigVerified: (TittleData *)tittle;
- (void) standardConfigDone: (int)ackCode;
@end

@interface TittleLightControl : NSObject

@property (nonatomic, weak) id <TittleLightControlDelegate> delegate;

@property (strong, nonatomic) SocketConnection *socketConnection;
@property (strong, nonatomic) UDPSocketConnection *udpSocketConnection;
@property (strong, nonatomic) GCDAsyncSocket *socketListener;
@property (strong, nonatomic) NSNetService *socketService;
@property (strong, nonatomic) NSTimer *onloadTimer;
@property (strong, nonatomic) NSMutableArray *foundTittles;
@property (strong, nonatomic) NSMutableArray *connectedSockets;

@property (assign, nonatomic) int currentMode;
@property (strong, nonatomic) TittleData *theConfigTittle;

- (void) setLightModeWithR: (int)r G:(int)g B:(int)b intensity: (int)intensity;
- (void) connectTittleWithIP: (NSString *)ip;
- (void) disconnectTittle;
- (void) startSearchingTittles;
- (void) stopSearchingTittles;
- (void) standardConfig: (NSString *)wifiName password: (NSString *)password;
- (void) connectTittleForStandardConfig;
- (void) verifyStandardConfig;
- (void) confirmStandardConfig: (NSString *)ip;
@end

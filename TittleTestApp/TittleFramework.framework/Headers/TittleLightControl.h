//
//  TittleLightControl.h
//  TittleFramework
//
//  Created by Jackie on 30/8/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"
#import "SocketConnection.h"

@interface TittleLightControl : NSObject

@property (strong, nonatomic) SocketConnection *socketConnection;

- (void) setLightModeInController: (id)controller R: (int)r G:(int)g B:(int)b intensity: (int)intensity;
- (void) connectTittleWithController: (id)controller ip: (NSString *)ip;
- (int)getAckCodeFromData:(NSData *)data;
@end

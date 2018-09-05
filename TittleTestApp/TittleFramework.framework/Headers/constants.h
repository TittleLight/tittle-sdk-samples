//
//  constants.h
//  TittleFramework
//
//  Created by Jackie on 3/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

#ifndef constants_h
#define constants_h

#define SOCKET_POOL 100
#define TITTLE_STANDARD_CONFIG_IP @"192.168.1.1"

//Ports
#define TITTLE_DEFAULT_SOCKET_PORT 9999
#define TITTLE_DEFAULT_BROADCAST_PORT 10000
#define TITTLE_DEFAULT_SOCKET_LISTENER_PORT 9999
#define TITTLE_STANDARD_CONFIG_PORT 9999

//command length
#define TITTLE_COMMAND_LIGHT_LENGTH 7


// socket tags
#define TITTLE_COMMAND_NEW_TITTLE_TAG 55
#define TITTLE_COMMAND_LIGHT_MODE 1
#define TITTLE_COMMAND_BROADCAST_TAG 2
#define TITTLE_COMMAND_STANDARD_CONFIG 3
#define TITTLE_COMMAND_VERIFY_STANDARD_CONFIG 4
#define TITTLE_COMMAND_DONE_STANDARD_CONFIG 5

//Ack codes
#define TITTLE_ACK_SUCCESS 0
#define TITTLE_ACK_RESEND 1
#define TITTLE_ACK_READY_FOR_DATA 2
#define TITTLE_ACK_UNKNOWN 3

// Tittle doing mode
#define  TITTLE_DOING_DEFAULT 0
#define  TITTLE_DOING_STANDARD_CONFIG 1

#endif /* constants_h */

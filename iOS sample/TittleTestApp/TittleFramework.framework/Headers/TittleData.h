//
//  TittleData.h
//  TittleFramework
//
//  Created by Jackie on 4/9/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TittleData : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ip;

-(void)assignAttributes: (NSString *)name ip: (NSString *)ip;
@end

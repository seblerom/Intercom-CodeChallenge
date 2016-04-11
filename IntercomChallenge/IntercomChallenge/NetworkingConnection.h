//
//  NetworkingConnection.h
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NetworkingConnection : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

- (void)jsonRequestWithBaseURL:(NSString *)baseURL completion:(void (^)( NSMutableArray * allCustomers, BOOL success))completion;
@end

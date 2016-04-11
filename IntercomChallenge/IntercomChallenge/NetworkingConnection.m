//
//  NetworkingConnection.m
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "NetworkingConnection.h"
#import "Customer.h"
#import "CustomerDAO.h"

@interface NetworkingConnection()
@property (nonatomic,strong) CustomerDAO * customerDao;
@end

@implementation NetworkingConnection

- (void)jsonRequestWithBaseURL:(NSString *)baseURL completion:(void (^)( NSMutableArray * allCustomers, BOOL success))completion{
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setHTTPAdditionalHeaders:
     @{@"Accept": @"application/json"}];
    
    sessionConfiguration.timeoutIntervalForRequest = 30.0;
    sessionConfiguration.timeoutIntervalForResource = 60.0;
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                           delegate:self
                                                      delegateQueue:nil];
    
    
    
    NSURLSessionDownloadTask * downLoadFile = [session downloadTaskWithURL:[NSURL URLWithString:baseURL] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            self.customerDao = [[CustomerDAO alloc]init];
            [self.customerDao deleteDataFromModel:@"Customer"];
            NSArray * arrayOfStringsWithCustomersData = [[[[NSString alloc] initWithData:[NSData dataWithContentsOfURL:location] encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\"" withString:@""]componentsSeparatedByString:@"\n"];
            
            for (NSString * singleCustomer in arrayOfStringsWithCustomersData) {
                
                NSString * singleCustomerAux = [[[[singleCustomer stringByReplacingOccurrencesOfString:@"\"" withString:@""]stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@""] ;
                
                NSArray * other = [singleCustomerAux componentsSeparatedByString:@" "];
                
                Customer * customer = [[Customer alloc]initWithLatitude:[[other objectAtIndex:1] doubleValue] longitude:[[other objectAtIndex:8] doubleValue] userId:[[other objectAtIndex:3] intValue] name:[[[other objectAtIndex:5] stringByAppendingString:@" "]stringByAppendingString:[other objectAtIndex:6]]];
    
                [self.customerDao setCustomer:customer];
            }
            
            if (completion) {
                NSMutableArray * allCustomers = [self.customerDao getCustomers];
                completion(allCustomers, YES);
            }
        }

    }];
    
    [downLoadFile resume];
    
}
@end

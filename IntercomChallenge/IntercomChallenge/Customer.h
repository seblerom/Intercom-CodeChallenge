//
//  Customer.h
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

- (id)initWithLatitude:(double)latitude longitude:(double)longitude userId:(int)userId name:(NSString*)name;

-(double)getLatitude;
-(double)getLongitude;
-(int)getUserId;
-(NSString*)getName;
@end

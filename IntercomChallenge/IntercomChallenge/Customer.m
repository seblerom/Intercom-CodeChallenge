//
//  Customer.m
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "Customer.h"

@interface Customer()

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) int userId;
@property (nonatomic,strong) NSString * name;
@end

@implementation Customer

- (id)initWithLatitude:(double)latitude longitude:(double)longitude userId:(int)userId name:(NSString*)name{
    
    self = [super init];
    if( self )
    {
        self.latitude = latitude;
        self.longitude = longitude;
        self.userId = userId;
        self.name = name;
    }
    return self;
}

-(double)getLatitude{
    return self.latitude;
}

-(double)getLongitude{
    return self.longitude;
}

-(int)getUserId{
    return self.userId;
}

-(NSString*)getName{
    return self.name;
}
@end

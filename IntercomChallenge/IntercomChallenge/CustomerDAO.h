//
//  CustomerDAO.h
//  IntercomChallenge
//
//  Created by alvaro sebastian leon romero on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"
#import "MasterDAO.h"
@interface CustomerDAO : MasterDAO
-(void)setCustomer:(Customer*)customerObject;
-(NSMutableArray*)getCustomers;
@end

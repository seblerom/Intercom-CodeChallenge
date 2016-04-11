//
//  CustomerDAO.m
//  IntercomChallenge
//
//  Created by alvaro sebastian leon romero on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "CustomerDAO.h"
#import "AppDelegate.h"

@interface CustomerDAO()
@property (nonatomic,weak) AppDelegate * appDelegate;
@property NSManagedObject * managedObject;
@end

@implementation CustomerDAO

-(void)setCustomer:(Customer*)customerObject{
    
    self.appDelegate = [AppDelegate appDelegate];
    NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
    
    self.managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:context];
    
    [self.managedObject setValue:[NSNumber numberWithDouble:[customerObject getLatitude]] forKey:@"latitude"];
    [self.managedObject setValue:[NSNumber numberWithDouble:[customerObject getLongitude]] forKey:@"longitude"];
    [self.managedObject setValue:[NSNumber numberWithInt:[customerObject getUserId]] forKey:@"userId"];
    [self.managedObject setValue:[customerObject getName] forKey:@"name"];

    NSError *error;
    [context save:&error];
    
}

-(NSMutableArray*)getCustomers{
    
    self.appDelegate = [AppDelegate appDelegate];
    NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"userId" ascending:YES];
    
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSMutableArray * results = [[context executeFetchRequest:request error:&error]mutableCopy];
    
    if (results.count > 0) {
        [context save:&error];
        return results;
    }
    [context save:&error];
    return nil;
    
}

@end

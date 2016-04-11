//
//  MasterDAO.m
//  IntercomChallenge
//
//  Created by alvaro sebastian leon romero on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "MasterDAO.h"
#import "AppDelegate.h"

@interface MasterDAO()
@property (nonatomic,weak) AppDelegate * appDelegate;
@property NSManagedObject * managedObject;
@end

@implementation MasterDAO

-(void)deleteDataFromModel:(NSString*)entityToDelete{
    
    self.appDelegate = [AppDelegate appDelegate];
    NSManagedObjectContext * context = [self.appDelegate managedObjectContext];
    NSEntityDescription * entity = [NSEntityDescription entityForName:entityToDelete inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    for (NSManagedObject * dataToDelete in results) {
        [context deleteObject:dataToDelete];
    }
    
    [context save:&error];
}

@end

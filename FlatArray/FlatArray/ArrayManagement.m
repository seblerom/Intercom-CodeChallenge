//
//  ArrayManagement.m
//  FlatArray
//
//  Created by Sebastian Leon on 1/28/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "ArrayManagement.h"

@interface ArrayManagement()

@property (nonatomic,strong) NSMutableArray * arrayFlatened;

@end

@implementation ArrayManagement

#pragma Useful functions for checking and printing arrays.

-(NSString*)convertArrayToString:(NSArray*)arrayInput{
    
    NSError *error = nil;
    NSData * arrayAsData = [NSJSONSerialization dataWithJSONObject:arrayInput options:kNilOptions error:&error];
    NSString * arrayAsString = [[NSString alloc] initWithData:arrayAsData encoding:NSUTF8StringEncoding];
    
    return arrayAsString;
}

-(BOOL)checkIfIsAnArrayObjectWithObject:(id)anyObject{
    
    if ([anyObject isKindOfClass:[NSArray class]] || [anyObject isKindOfClass:[NSMutableArray class]] ) {
        return YES;
    }
    return NO;
}

-(BOOL)checkIfIsAnEmptyArray:(NSArray*)arrayCheck{
    if (arrayCheck != nil && [arrayCheck count] > 0) {
        return YES;
    }
    return NO;
}

-(void)initializeArray{
    self.arrayFlatened = [NSMutableArray array];
}

#pragma Recursive function to flatten array
-(NSMutableArray*)convertArrayToFlattenArrayWith:(NSArray*)entryData{
    
    for (int i = 0; i < entryData.count; i++) {
        if ([[entryData objectAtIndex:i] isKindOfClass:[NSArray class]]) {
            NSArray * nestedArray = [entryData objectAtIndex:i];
            [self convertArrayToFlattenArrayWith:nestedArray];
        }else{
            [self.arrayFlatened addObject:[entryData objectAtIndex:i]];
        }
    }
    
    return self.arrayFlatened;
}

@end

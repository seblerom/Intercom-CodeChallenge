//
//  ArrayManagement.h
//  FlatArray
//
//  Created by Sebastian Leon on 1/28/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayManagement : NSObject

-(NSString*)convertArrayToString:(NSArray*)arrayInput;
-(BOOL)checkIfIsAnArrayObjectWithObject:(id)anyObject;
-(BOOL)checkIfIsAnEmptyArray:(NSArray*)arrayCheck;
-(NSMutableArray*)convertArrayToFlattenArrayWith:(NSArray*)entryData;
-(void)initializeArray;
@end

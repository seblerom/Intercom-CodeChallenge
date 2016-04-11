//
//  DataTestingArray.m
//  FlatArray
//
//  Created by Sebastian Leon on 1/28/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "DataTestingArray.h"

@implementation DataTestingArray


#pragma Creating Data for testing
-(NSArray*)creatingPlainArrayForTesting{
    
    NSMutableArray * plainArrayOfIntegers = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++)
        [plainArrayOfIntegers addObject:[NSNumber numberWithInteger:i]];
    
    return plainArrayOfIntegers;
}

-(NSArray*)creatingArrayInArrayForTesting{
    
    NSMutableArray * plainArrayOfIntegers = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++)
        [plainArrayOfIntegers addObject:[NSNumber numberWithInteger:i]];
    
    NSMutableArray * plainArrayOfIntegers2nd = [NSMutableArray array];
    for (NSInteger i = 50; i > 0; i--)
        [plainArrayOfIntegers2nd addObject:[NSNumber numberWithInteger:i]];
    
    NSMutableArray * plainArrayOfIntegers3rd = [NSMutableArray array];
    for (NSInteger i = 50; i < 100; i++)
        [plainArrayOfIntegers3rd addObject:[NSNumber numberWithInteger:i]];
    
    NSArray * arraInArray = [[NSArray alloc]initWithObjects:plainArrayOfIntegers,[NSNumber numberWithInt:1111],plainArrayOfIntegers2nd,[NSNumber numberWithInt:2222],plainArrayOfIntegers3rd,[NSNumber numberWithInt:3333], nil];
    
    return arraInArray;
}

-(NSArray*)creatingComplexArrayForTesting{
    
    
    NSMutableArray *myIntegers = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++)
        [myIntegers addObject:[NSNumber numberWithInteger:i]];
    
    NSMutableArray *myIntegers2 = [NSMutableArray array];
    for (NSInteger i = 10; i < 20; i++)
        [myIntegers2 addObject:[NSNumber numberWithInteger:i]];
    
    NSArray * arrayWith2Arrays = [[NSArray alloc]initWithObjects:myIntegers,myIntegers2, nil];
    
    NSMutableArray *myIntegers3 = [NSMutableArray array];
    for (NSInteger i = 20; i < 30; i++)
        [myIntegers3 addObject:[NSNumber numberWithInteger:i]];
    
    NSMutableArray * arrayBidimensional = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        NSMutableArray * auxArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < 8; j++) {
            [auxArray addObject:[NSNumber numberWithInt:0]];
        }
        [arrayBidimensional addObject:auxArray];
    }
    
    NSMutableArray * anotherArray = [[NSMutableArray alloc] initWithCapacity: 7];
    
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],nil] atIndex:0];
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],nil] atIndex:1];
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],nil] atIndex:2];
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],nil] atIndex:3];
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:13],[NSNumber numberWithInt:14],[NSNumber numberWithInt:15],nil] atIndex:4];
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:16],[NSNumber numberWithInt:17],[NSNumber numberWithInt:18],nil] atIndex:5];
    [anotherArray insertObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:19],[NSNumber numberWithInt:20],[NSNumber numberWithInt:21],nil] atIndex:6];
    
    NSArray * complexArray = [[NSArray alloc]initWithObjects:myIntegers,[NSNumber numberWithInt:11111],myIntegers2,[NSNumber numberWithInt:22222],arrayWith2Arrays,[NSNumber numberWithInt:33333],myIntegers3,[NSNumber numberWithInt:44444],arrayBidimensional,[NSNumber numberWithInt:55555],anotherArray,[NSNumber numberWithInt:66666],nil];
    
    NSArray * veryComplexArray = [[NSArray alloc]initWithObjects:complexArray,[NSNumber numberWithInt:00000],myIntegers,[NSNumber numberWithInt:11111],myIntegers2,[NSNumber numberWithInt:22222],arrayWith2Arrays,[NSNumber numberWithInt:33333],myIntegers3,[NSNumber numberWithInt:44444],arrayBidimensional,[NSNumber numberWithInt:55555],anotherArray,[NSNumber numberWithInt:66666],nil];
    
    return veryComplexArray;
}


@end

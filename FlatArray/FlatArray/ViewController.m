//
//  ViewController.m
//  FlatArray
//
//  Created by Sebastian Leon on 1/26/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "ViewController.h"
#import "ArrayManagement.h"
#import "DataTestingArray.h"

#define BORDER_WIDTH 1
#define BORDER_COLOR [UIColor lightGrayColor].CGColor
#define CORNER_RADIUS 5


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *viewContainer;
#pragma Outlets and Actions for buttons
@property (strong, nonatomic) IBOutlet UIButton *buttonTestNotAnArray;
@property (strong, nonatomic) IBOutlet UIButton *buttonTestEmptyArray;
@property (strong, nonatomic) IBOutlet UIButton *buttonTestPlainArray;
@property (strong, nonatomic) IBOutlet UIButton *buttonTestArrayInArray;
@property (strong, nonatomic) IBOutlet UIButton *buttonTestComplexArray;
@property (strong, nonatomic) IBOutlet UIView *viewButtons;

- (IBAction)buttonTestNotAnArray:(id)sender;
- (IBAction)buttonTestEmptyArray:(id)sender;
- (IBAction)buttonTestPlainArray:(id)sender;
- (IBAction)buttonTestArrayInArray:(id)sender;
- (IBAction)buttonTestComplexArray:(id)sender;


#pragma Outlets and Actions Data input
@property (strong, nonatomic) IBOutlet UITextView *textViewInput;
@property (strong, nonatomic) IBOutlet UIView *viewDataInput;


#pragma Outlets and Actions Data output
@property (strong, nonatomic) IBOutlet UITextView *textViewOutput;
@property (strong, nonatomic) IBOutlet UIView *viewDataOutput;


@property (nonatomic,strong) NSMutableArray * arrayFlatened;
@property (nonatomic,strong) ArrayManagement * arrayManagement;
@property (nonatomic,strong) DataTestingArray * dataTestingArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewsAndShapes];
    self.arrayManagement = [[ArrayManagement alloc]init];
    self.dataTestingArray = [[DataTestingArray alloc]init];
}

#pragma Setting shapes for UI
-(void)setViewsAndShapes{
    
    self.buttonTestNotAnArray.layer.borderWidth = BORDER_WIDTH;
    self.buttonTestEmptyArray.layer.borderWidth = BORDER_WIDTH;
    self.buttonTestPlainArray.layer.borderWidth = BORDER_WIDTH;
    self.buttonTestArrayInArray.layer.borderWidth = BORDER_WIDTH;
    self.buttonTestComplexArray.layer.borderWidth = BORDER_WIDTH;
    
    self.buttonTestNotAnArray.layer.borderColor =BORDER_COLOR;
    self.buttonTestEmptyArray.layer.borderColor = BORDER_COLOR;
    self.buttonTestPlainArray.layer.borderColor = BORDER_COLOR;
    self.buttonTestArrayInArray.layer.borderColor = BORDER_COLOR;
    self.buttonTestComplexArray.layer.borderColor = BORDER_COLOR;
    
    self.buttonTestNotAnArray.layer.cornerRadius =CORNER_RADIUS;
    self.buttonTestEmptyArray.layer.cornerRadius = CORNER_RADIUS;
    self.buttonTestPlainArray.layer.cornerRadius = CORNER_RADIUS;
    self.buttonTestArrayInArray.layer.cornerRadius = CORNER_RADIUS;
    self.buttonTestComplexArray.layer.cornerRadius = CORNER_RADIUS;
    
    self.viewContainer.layer.cornerRadius = CORNER_RADIUS;
    self.textViewInput.layer.borderWidth = BORDER_WIDTH;
    self.textViewInput.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.textViewInput.layer.cornerRadius = CORNER_RADIUS;
    
    self.textViewOutput.layer.borderWidth = BORDER_WIDTH;
    self.textViewOutput.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.textViewOutput.layer.cornerRadius = CORNER_RADIUS;
    
    
    self.textViewInput.editable=NO;
    self.textViewOutput.editable=NO;
}

#pragma Button actions

- (IBAction)buttonTestNotAnArray:(id)sender {
    
    self.textViewInput.text = [@"Object used for test NSNumber Object with integer: " stringByAppendingString:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:1555555]]];
    BOOL isOk = [self.arrayManagement checkIfIsAnArrayObjectWithObject:[NSNumber numberWithInt:1555555]];
    if (!isOk) {
        self.textViewOutput.text = @"Come on men, thats not even an array";
    }
}

- (IBAction)buttonTestEmptyArray:(id)sender {
    
    self.textViewInput.text = @"Object of type NSArray allocated in memory = [[NSArray alloc] init] ";
    BOOL isEmpty = [self.arrayManagement checkIfIsAnEmptyArray:[[NSArray alloc] init]];
    if (!isEmpty) {
        self.textViewOutput.text = @"There's an array allocated in memory but there is nothing in it";
    }
}
- (IBAction)buttonTestPlainArray:(id)sender {
    
    [self initializeArray];
    NSArray * plainArray = [self.dataTestingArray creatingPlainArrayForTesting];
    if ([self.arrayManagement checkIfIsAnArrayObjectWithObject:plainArray] && [self.arrayManagement checkIfIsAnEmptyArray:plainArray]) {
        [self.arrayManagement initializeArray];
        self.textViewInput.text = [@"Array object: " stringByAppendingString:[self.arrayManagement convertArrayToString:plainArray]];
        self.arrayFlatened = [self.arrayManagement convertArrayToFlattenArrayWith:plainArray];
        self.textViewOutput.text = [self.arrayManagement convertArrayToString:self.arrayFlatened];
    }
    
}

- (IBAction)buttonTestArrayInArray:(id)sender {
    
    [self initializeArray];
    NSArray * arrayInArray = [self.dataTestingArray creatingArrayInArrayForTesting];
    if ([self.arrayManagement checkIfIsAnArrayObjectWithObject:arrayInArray] && [self.arrayManagement checkIfIsAnEmptyArray:arrayInArray]) {
        [self.arrayManagement initializeArray];
        self.textViewInput.text = [@"Array object: " stringByAppendingString:[self.arrayManagement convertArrayToString:arrayInArray]];
        self.arrayFlatened = [self.arrayManagement convertArrayToFlattenArrayWith:arrayInArray];
        self.textViewOutput.text = [self.arrayManagement convertArrayToString:self.arrayFlatened];
    }
}

- (IBAction)buttonTestComplexArray:(id)sender {
    
    [self initializeArray];
    NSArray * complexArray = [self.dataTestingArray creatingComplexArrayForTesting];
    if ([self.arrayManagement checkIfIsAnArrayObjectWithObject:complexArray] && [self.arrayManagement checkIfIsAnEmptyArray:complexArray]) {
        [self.arrayManagement initializeArray];
        self.textViewInput.text = [@"Array object: " stringByAppendingString:[self.arrayManagement convertArrayToString:complexArray]];
        self.arrayFlatened = [self.arrayManagement convertArrayToFlattenArrayWith:complexArray];
        self.textViewOutput.text = [self.arrayManagement convertArrayToString:self.arrayFlatened];
    }
}

#pragma Setting array

-(void)initializeArray{
    self.arrayFlatened = nil;
    self.arrayFlatened = [NSMutableArray array];
}

@end

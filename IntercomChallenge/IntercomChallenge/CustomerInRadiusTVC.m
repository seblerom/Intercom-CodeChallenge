//
//  CustomerInRadiusTVC.m
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/25/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "CustomerInRadiusTVC.h"
#import "NetworkingConnection.h"
#import "AppDelegate.h"
#import "Customer.h"
#import "MapViewController.h"

#define dublinLatitude 53.3381985
#define dublinLongitude -6.2592576
#define radiusDistance 100000

@interface CustomerInRadiusTVC ()
- (IBAction)buttonShowMe:(id)sender;
@property (nonatomic,strong) NSMutableArray * allCustomers;
@property (nonatomic,strong) NSDictionary * polylineCoordinates;
@property (nonatomic)double distanceBetweenOriginAndSingleUser;
@property (nonatomic,strong) CLCircularRegion * dublinCircularRegion;
@property (strong, nonatomic) IBOutlet UIView *viewForMapIcon;
@property (nonatomic) CLLocationCoordinate2D dublinCoordinates;
@property (nonatomic)int index;
@end

@implementation CustomerInRadiusTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewForMapIcon.layer.cornerRadius = self.viewForMapIcon.bounds.size.width/2;
    self.viewForMapIcon.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1];
    
    self.dublinCoordinates = CLLocationCoordinate2DMake(dublinLatitude, dublinLongitude);
    
    self.dublinCircularRegion = [[CLCircularRegion alloc]initWithCenter:self.dublinCoordinates radius:radiusDistance identifier:@"Dublin"];
    NetworkingConnection * downloadFile = [[NetworkingConnection alloc]init];
    [downloadFile jsonRequestWithBaseURL:[AppDelegate getUrlFromPlistFileWithKey:@"URL_GIST_FILE"] completion:^(NSMutableArray *allCustomers, BOOL success) {
        if (success) {
            self.allCustomers = [NSMutableArray array];
            for (Customer * singleCustomer in allCustomers) {
                CLLocationCoordinate2D userCoordinates;
                userCoordinates.latitude = [[singleCustomer valueForKey:@"latitude"] doubleValue];
                userCoordinates.longitude = [[singleCustomer valueForKey:@"longitude"] doubleValue];
                BOOL isInRange = [self checkIfUserCoordinatesInRange:self.dublinCircularRegion userCoordinates:userCoordinates];
                if (isInRange) {
                    [self.allCustomers addObject:singleCustomer];
                }
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allCustomers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customerInRadius" forIndexPath:indexPath];
    
    Customer * customer = [self.allCustomers objectAtIndex:indexPath.row];
    cell.textLabel.text = [@"Customer name: " stringByAppendingString:[customer valueForKey:@"name"]];
    cell.textLabel.textColor = [UIColor colorWithRed:64.0/255.0 green:120.0/255.0 blue:192.0/255.0 alpha:1];
    cell.detailTextLabel.text = [@"User id: " stringByAppendingString:[NSString stringWithFormat:@"%i",[[customer valueForKey:@"userId"] intValue]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.index = indexPath.row;
    self.polylineCoordinates = [self getCoordinatesForPolyLine:indexPath.row];
    self.distanceBetweenOriginAndSingleUser = [self calculateDistanceOriginToUserPosition:indexPath.row];
    [self performSegueWithIdentifier:@"singleCustomerSegue" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(NSDictionary*)getCoordinatesForPolyLine:(int)index{
    
    NSDictionary * polylineCoordinates = [[NSDictionary alloc]initWithObjectsAndKeys:[[self.allCustomers objectAtIndex:index] valueForKey:@"latitude"],@"customerlatitude",[[self.allCustomers objectAtIndex:index] valueForKey:@"longitude"],@"customerlongitude",[NSString stringWithFormat:@"%f",self.dublinCoordinates.latitude],@"dublinLatitude",[NSString stringWithFormat:@"%f",self.dublinCoordinates.longitude],@"dublinLongitude", nil];
    
    return polylineCoordinates;
}

-(double)calculateDistanceOriginToUserPosition:(int)index{
    
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.dublinCoordinates.latitude longitude:self.dublinCoordinates.longitude];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[[[self.allCustomers objectAtIndex:index]valueForKey:@"latitude"] doubleValue] longitude:[[[self.allCustomers objectAtIndex:index]valueForKey:@"longitude"] doubleValue]];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    return distance;
}

-(BOOL)checkIfUserCoordinatesInRange:(CLCircularRegion*)dublinCircularRegion userCoordinates:(CLLocationCoordinate2D)userCoordinates{
    
    BOOL isInsideRegion = [dublinCircularRegion containsCoordinate:userCoordinates];
    return isInsideRegion;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toMapSegue"]) {
        MapViewController * mapView = segue.destinationViewController;
        mapView.customersInRange = self.allCustomers;
        mapView.dublinCoordinates = self.dublinCoordinates;
    }else if ([segue.identifier isEqualToString:@"singleCustomerSegue"]){
        MapViewController * mapView = segue.destinationViewController;
        mapView.dublinCoordinates = self.dublinCoordinates;
        mapView.polilyneInfo = self.polylineCoordinates;
        mapView.dintanceOriginDestiny = self.distanceBetweenOriginAndSingleUser;
        mapView.singleCustomer = [self.allCustomers objectAtIndex:self.index];
    }
}
- (IBAction)buttonShowMe:(id)sender {
    [self performSegueWithIdentifier:@"toMapSegue" sender:self];
}
@end

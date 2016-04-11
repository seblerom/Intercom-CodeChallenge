//
//  MapViewController.m
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/26/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import "MapViewController.h"
#import "Customer.h"
@interface MapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineRenderer *routeLineView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawIntercomOfficesAnnotationWithCoordinate:self.dublinCoordinates];
    if (self.customersInRange.count > 0) {
        [self drawPointsOnMapForCustomersInRange:self.customersInRange withOriginCoordinates:self.dublinCoordinates];
    }else if (self.polilyneInfo.count > 0){
        [self drawPolylineWithCoordinates:self.polilyneInfo andDistance:self.dintanceOriginDestiny];
    }

}

-(void)drawIntercomOfficesAnnotationWithCoordinate:(CLLocationCoordinate2D)intercomCoordinates{
    MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:intercomCoordinates];
    annotation.title = @"Intercom Offices";
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:NO];
}

-(void)drawPointsOnMapForCustomersInRange:(NSMutableArray*)customersInRange withOriginCoordinates:(CLLocationCoordinate2D)dublinCoordinates{

    for (Customer * singleCustomerObject in customersInRange) {
        CLLocationCoordinate2D userCoordinate;
        userCoordinate.latitude = [[singleCustomerObject valueForKey:@"latitude"] doubleValue];
        userCoordinate.longitude = [[singleCustomerObject valueForKey:@"longitude"] doubleValue];
        MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:userCoordinate];
        annotation.title = [singleCustomerObject valueForKey:@"name"];
        annotation.subtitle = [NSString stringWithFormat:@"%@",[singleCustomerObject valueForKey:@"userId"]];
        [self.mapView addAnnotation:annotation];
    }
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(dublinCoordinates, 200000,400000);
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
}

-(void)drawPolylineWithCoordinates:(NSDictionary*)polylineCoordinates andDistance:(double)distance{
    
    CLLocationCoordinate2D coordinateArray[2];
    coordinateArray[0] = CLLocationCoordinate2DMake([[polylineCoordinates valueForKey:@"customerlatitude"] doubleValue],[[polylineCoordinates valueForKey:@"customerlongitude"] doubleValue]);
    coordinateArray[1] = CLLocationCoordinate2DMake([[polylineCoordinates valueForKey:@"dublinLatitude"] doubleValue],[[polylineCoordinates valueForKey:@"dublinLongitude"] doubleValue]);
    
    self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
    [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
    
    [self.mapView addOverlay:self.routeLine];
    
}

-(MKPolylineRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay == self.routeLine)
    {
        if(nil == self.routeLineView)
        {
            self.routeLineView = [[MKPolylineRenderer alloc] initWithPolyline:self.routeLine];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor blueColor];
            self.routeLineView.lineWidth = 5;

        }
        return self.routeLineView;
    }
    
    return nil;
}
-(void)centerPointsOnMap{
    
    float centerCoordinateLongitude = (([[self.polilyneInfo valueForKey:@"customerlongitude"] doubleValue] + [[self.polilyneInfo valueForKey:@"dublinLongitude"] doubleValue]) / 2);
    float centerCoordinateLatitude = (([[self.polilyneInfo valueForKey:@"customerlatitude"] doubleValue] + [[self.polilyneInfo valueForKey:@"dublinLatitude"] doubleValue]) / 2);
    
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = centerCoordinateLatitude;
    centerCoordinate.longitude = centerCoordinateLongitude;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, self.dintanceOriginDestiny/0.9,self.dintanceOriginDestiny/0.9);
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
    [self drawPointsOriginAndDestiny:@{@"longitude":[self.polilyneInfo valueForKey:@"customerlongitude"],@"latitude":[self.polilyneInfo valueForKey:@"customerlatitude"]}];
}

-(void)drawPointsOriginAndDestiny:(NSDictionary*)coordinates{
    
        CLLocationCoordinate2D userCoordinate;
        userCoordinate.latitude = [[self.singleCustomer valueForKey:@"latitude"] doubleValue];
        userCoordinate.longitude = [[self.singleCustomer valueForKey:@"longitude"] doubleValue];
        MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:userCoordinate];
        annotation.title = [self.singleCustomer valueForKey:@"name"];
        annotation.subtitle = [NSString stringWithFormat:@"%@",[self.singleCustomer valueForKey:@"userId"]];
        [self.mapView addAnnotation:annotation];
       [self.mapView selectAnnotation:annotation animated:NO];
}

-(void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered{
    if (self.polilyneInfo.count > 0){
        [self centerPointsOnMap];
    }
    
}
@end

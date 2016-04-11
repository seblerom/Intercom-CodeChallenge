//
//  MapViewController.h
//  IntercomChallenge
//
//  Created by Sebastian Leon on 1/26/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic,strong) NSMutableArray * customersInRange;
@property (nonatomic,strong) NSDictionary * polilyneInfo;
@property (nonatomic) CLLocationCoordinate2D dublinCoordinates;
@property (nonatomic)double dintanceOriginDestiny;
@property (nonatomic,strong) NSMutableArray * singleCustomer;
@end

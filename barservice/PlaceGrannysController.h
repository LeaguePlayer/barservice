//
//  PlaceGrannysController.h
//  barservice
//
//  Created by Leonid Minderov on 22.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrannysController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PlaceGrannysController : GrannysController


@property (nonatomic, retain) GMSMapView *map;
@property(nonatomic,retain) CLLocationManager *locationManager;

@end

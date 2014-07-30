//
//  PlaceIcemanController.h
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IceManController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PlaceIcemanController : IceManController

@property (nonatomic, retain) GMSMapView *map;
@property(nonatomic,retain) CLLocationManager *locationManager;

@end

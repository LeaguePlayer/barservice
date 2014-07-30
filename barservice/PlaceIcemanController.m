//
//  PlaceIcemanController.m
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "PlaceIcemanController.h"

@interface PlaceIcemanController ()

@end

@implementation PlaceIcemanController
@synthesize map;
@synthesize locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // подключаем гугл карту
    [GMSServices provideAPIKey:APIKeyGoogleMap];
    map = [[GMSMapView alloc] initWithFrame:self.viewScroll.bounds];
    map = [GMSMapView mapWithFrame:CGRectZero camera:nil];
    map.myLocationEnabled = YES;
    self.view = map;
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getstreet/site/iceman",domain_server_api];
    
    //self.apiString
    [self startAPI];
    
    // Do any additional setup after loading the view.
}

-(void)completeApi
{
    // NSLog(@"%@",[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"thumb"]);
    
    [self buildContent];
}



-(void)buildContent
{
    // начинаем определять наши координаты
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    
    
    
    
    for (NSDictionary *point in [self.gotDataAPI objectForKey:@"response"])
    {
        
        [self.hud show:YES];
        NSString *decode =[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=false",[point objectForKey:@"street"]];
        
        NSString *urlInString = [decode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",urlInString);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:urlInString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // NSLog(@"data api got");
            
            
            for (NSDictionary* a in [responseObject objectForKey:@"results"])
            {
                
                NSDictionary *coordinates = [[a objectForKey:@"geometry"] objectForKey:@"location"];
                
                
                // создаем точку на карте
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake([[coordinates objectForKey:@"lat"] floatValue], [[coordinates objectForKey:@"lng"] floatValue]);
                
                marker.title = [point objectForKey:@"title"];
                marker.snippet = [point objectForKey:@"street"];
                marker.map = map;
                
                NSLog(@"lat:%f lng:%f",[[coordinates objectForKey:@"lat"] floatValue],[[coordinates objectForKey:@"lng"] floatValue]);
            }
            
            //            NSDictionary *results = [responseObject objectForKey:@"results"];
            //            NSLog(@"results: %i",[results count]);
            //             NSLog(@"JSON: %@", results.description);
            
            // self.gotDataAPI = responseObject;
            //  [self completeApi];
            [self.hud hide:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self.hud hide:YES];
        }];
    }
    
}

- (void)locationManager:(CLLocationManager *)locationManager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;
{
    NSLog(@"tt");
    
    float x_camera = (57.14071 - newLocation.coordinate.latitude)/2;
    float y_camera = (65.570318 - newLocation.coordinate.longitude)/2;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude+x_camera
                                                            longitude:newLocation.coordinate.longitude+y_camera
                                                                 zoom:13];
    [map setCamera:camera];
    
    
    
    
    
    
    
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  CircleCenterAnnotation.h
//  MovingCircleMapView
//
//  Created by Carlo Bation on 11/26/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <MapKit/MapKit.h>
@interface CircleCenterAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) id parent;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

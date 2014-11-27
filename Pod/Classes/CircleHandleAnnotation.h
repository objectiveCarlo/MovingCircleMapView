//
//  CircleHandleAnnotation.h
//  MovingCircleMapView
//
//  Created by Carlo Bation on 11/26/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CircleHandleAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) id parent;

@property (nonatomic, assign) CLLocationDistance radius;

@property (nonatomic, assign) CLLocationCoordinate2D originalCoordinates;

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate withRadius:(CLLocationDistance)radius;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

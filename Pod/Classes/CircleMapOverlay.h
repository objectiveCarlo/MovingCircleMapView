//
//  CircleMapOverlay.h
//  MovingCircleMapView
//
//  Created by Carlo Bation on 11/27/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CircleMapOverlay : MKCircle

@property (strong, nonatomic) id content;

@end

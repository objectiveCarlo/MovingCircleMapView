//
//  CircleCenterAnnotation.m
//  MovingCircleMapView
//
//  Created by Carlo Bation on 11/26/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "CircleCenterAnnotation.h"

@implementation CircleCenterAnnotation

@synthesize coordinate;


- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    coordinate=coord;
    return self;
}

-(CLLocationCoordinate2D)coord
{
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}


@end

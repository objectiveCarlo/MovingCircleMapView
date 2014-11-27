//
//  CircularAnnotationManager.h
//  MovingCircleMapView
//
//  Created by Carlo Bation on 11/27/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class CircleMapOverlay;

@interface CircularAnnotationManager : NSObject

+ (CircularAnnotationManager *)makeAnnotationsWithCoordinate:(CLLocationCoordinate2D)newCoordinate withRadius:(CLLocationDistance)radius;

+ (CLLocationDistance)computeNewRadius:(CLLocationCoordinate2D)newCoordinates withCenter:(CLLocationCoordinate2D)center;

+ (BOOL)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState;


@property (nonatomic, strong) CircleMapOverlay *circleOverlay;

@property (nonatomic, strong) id metaData;

- (CLLocationDistance)computeNewRadiusWithNewCoordinatesOfHandle:(CLLocationCoordinate2D)newCoordinatesOfHandle;

- (void)updateRadius:(CLLocationDistance)radius mapView:(MKMapView *)mapView;

- (CircleMapOverlay *)updateRadius:(CLLocationDistance)radius;

- (void)updateCenterCoordinate:(CLLocationCoordinate2D)updateCenterCoordinate mapView:(MKMapView *)mapView;

- (NSArray *)getAnnotations;

@end

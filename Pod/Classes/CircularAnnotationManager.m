//
//  CircularAnnotationManager.m
//  MovingCircleMapView
//
//  Created by Carlo Bation on 11/27/14.
//  Copyright (c) 2014 CL. All rights reserved.
//

#import "CircularAnnotationManager.h"
#import "CircleCenterAnnotation.h"
#import "CircleHandleAnnotation.h"
#import "CircleMapOverlay.h"

@interface CircularAnnotationManager ()

@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) CircleCenterAnnotation *centerAnnotation;

@property (nonatomic, strong) CircleHandleAnnotation *handleAnnotation;

@end

@implementation CircularAnnotationManager


+ (CircularAnnotationManager *)makeAnnotationsWithCoordinate:(CLLocationCoordinate2D)newCoordinate withRadius:(CLLocationDistance)radius {

    CircularAnnotationManager *collection = [[CircularAnnotationManager alloc] initWithCoordinate:newCoordinate withRadius:radius];
    
    return collection;
}


+ (CLLocationDistance)computeNewRadius:(CLLocationCoordinate2D)newCoordinates withCenter:(CLLocationCoordinate2D)center {
    
    
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:newCoordinates.latitude longitude:newCoordinates.longitude];
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
    CLLocationDistance distance = [newLocation distanceFromLocation:centerLocation];
    
    return distance;
}


+ (BOOL)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    
    BOOL hasBeenModified = NO;
    
    if (newState == MKAnnotationViewDragStateEnding) {
        
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        
        if ([annotationView.annotation isKindOfClass:[CircleHandleAnnotation class]]) {
            
            
            CircleHandleAnnotation *annotation = annotationView.annotation ;
            
            if (annotation.parent && [annotation.parent respondsToSelector:@selector(updateRadius:mapView:)]) {
                
                CLLocationDistance newRadius = [annotation.parent computeNewRadiusWithNewCoordinatesOfHandle:droppedAt];
                
                [annotation.parent updateRadius:newRadius mapView:mapView];
            }
            
            hasBeenModified = YES;
            
        } else {
            
            if ([annotationView.annotation isKindOfClass:[CircleCenterAnnotation class]]) {
                
                CircleCenterAnnotation *annotation = annotationView.annotation ;
                
                if (annotation.parent && [annotation.parent respondsToSelector:@selector(updateCenterCoordinate:mapView:)]) {
                    
                    [annotation.parent updateCenterCoordinate:droppedAt mapView:mapView];
                }
                
                hasBeenModified = YES;
            }
        }
        
        if (hasBeenModified) {
            [annotationView setDragState:MKAnnotationViewDragStateNone];
        }
        
    }
    
    return hasBeenModified;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate withRadius:(CLLocationDistance)radius {
    
    self = [super init];
    
    if (self) {
        
        self.annotations = [[NSMutableArray alloc] init];
        
        self.circleOverlay = [CircleMapOverlay circleWithCenterCoordinate:newCoordinate radius:radius];
        
        self.centerAnnotation = [[CircleCenterAnnotation alloc] initWithCoordinate:newCoordinate];
    
        self.handleAnnotation = [[CircleHandleAnnotation alloc] initWithCoordinate:newCoordinate withRadius:radius];
        
        [self.annotations addObject:self.handleAnnotation];
        
        [self.annotations addObject:self.centerAnnotation];
        
        self.centerAnnotation.parent = self;
        
        self.handleAnnotation.parent = self;
        
    }
    
    return self;
}


- (CLLocationDistance)computeNewRadiusWithNewCoordinatesOfHandle:(CLLocationCoordinate2D)newCoordinatesOfHandle {
    
    return [CircularAnnotationManager computeNewRadius:newCoordinatesOfHandle withCenter:self.centerAnnotation.coordinate];
    
}


- (CircleMapOverlay *)updateRadius:(CLLocationDistance)radius {
    
    CircleMapOverlay *circle = [CircleMapOverlay circleWithCenterCoordinate:self.circleOverlay.coordinate radius:radius];
    
    CircleMapOverlay *previousCircle = self.circleOverlay;
    
    self.circleOverlay = circle;
    
    return previousCircle;
}

- (void)updateRadius:(CLLocationDistance)radius mapView:(MKMapView *)mapView {
    
    [self updateCircleOverlayWithCoordinate:self.circleOverlay.coordinate radius:radius mapView:mapView];
}

- (void)updateCircleOverlayWithCoordinate:(CLLocationCoordinate2D)newCoordinate radius:(CLLocationDistance)radius mapView:(MKMapView *)mapView {
    
    CircleMapOverlay *circle = [CircleMapOverlay circleWithCenterCoordinate:newCoordinate radius:radius];
    
    [mapView addOverlay:circle];
    [mapView removeOverlay:self.circleOverlay];
    
    self.circleOverlay = circle;
}

- (void)updateCenterCoordinate:(CLLocationCoordinate2D)newCoordinate mapView:(MKMapView *)mapView {
    
    [self.centerAnnotation setCoordinate:newCoordinate];
    [self.handleAnnotation setCoordinate:newCoordinate];
    
    [self updateCircleOverlayWithCoordinate:newCoordinate radius:self.circleOverlay.radius mapView:mapView];
}


- (NSArray *)getAnnotations {
    
    return self.annotations;
}
@end

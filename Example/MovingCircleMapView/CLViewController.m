//
//  CLViewController.m
//  MovingCircleMapView
//
//  Created by Carlo Luis Bation on 11/27/2014.
//  Copyright (c) 2014 Carlo Luis Bation. All rights reserved.
//

#import "CLViewController.h"
#import "CircleCenterAnnotation.h"
#import "CircleHandleAnnotation.h"
#import "CircularAnnotationManager.h"
#import "CircleMapOverlay.h"
@interface CLViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) CircularAnnotationManager *annotationManager;

@end

@implementation CLViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.annotationManager = [CircularAnnotationManager makeAnnotationsWithCoordinate:CLLocationCoordinate2DMake(14.576367, 121.085118) withRadius:10000];
    [self.mapView  setDelegate:self];
    [self.mapView addOverlay:self.annotationManager.circleOverlay];
    [self.mapView addAnnotations:[self.annotationManager getAnnotations]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - MKMapViewDelegate methods
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    
    NSString *possiblePinClass = NSStringFromClass([annotation class]);
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: possiblePinClass];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: possiblePinClass];
    } else {
        pin.annotation = annotation;
    }
    
    if ([possiblePinClass isEqualToString:@"CircleHandleAnnotation"]) {
        pin.pinColor = MKPinAnnotationColorGreen;
    } else {
        pin.pinColor = MKPinAnnotationColorRed;
    }
    
    pin.draggable = YES;
    
    return pin;
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    
    renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
    
    return renderer;
    
}
- (NSInteger)getNewRadius:(CLLocationCoordinate2D)newCoordinates withCenter:(CLLocationCoordinate2D)center {
    
    
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:newCoordinates.latitude longitude:newCoordinates.longitude];
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
    CLLocationDistance distance = [newLocation distanceFromLocation:centerLocation];
    
    return distance;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    [CircularAnnotationManager mapView:mapView annotationView:annotationView didChangeDragState:newState fromOldState:oldState];
}


@end

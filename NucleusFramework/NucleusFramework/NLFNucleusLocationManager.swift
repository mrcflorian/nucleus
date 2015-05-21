//
//  NLFNucleusLocationManager.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/21/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import CoreLocation

public let kNLFNucleusLocationManagerDidUpdateLocation = "kNLFNucleusLocationManagerDidUpdateLocation"

public class NLFNucleusLocationManager: NSObject, CLLocationManagerDelegate
{
    static let locationManager = CLLocationManager()
    public init(distanceFilter: CLLocationDistance = 1000) {
        super.init()
        NLFNucleusLocationManager.locationManager.delegate = self;
        NLFNucleusLocationManager.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;

        NLFNucleusLocationManager.locationManager.distanceFilter = distanceFilter;
    }

    public func startUpdatingLocation() {
            let status = CLLocationManager.authorizationStatus()
            if (status == CLAuthorizationStatus.NotDetermined) {
                NLFNucleusLocationManager.locationManager.requestWhenInUseAuthorization();
            }
            NLFNucleusLocationManager.locationManager.startUpdatingLocation()
    }

    public func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (locations.count > 0 && locations.last != nil) {
            let lastLocation = locations.last as! CLLocation
            NSNotificationCenter.defaultCenter().postNotificationName(kNLFNucleusLocationManagerDidUpdateLocation, object: self, userInfo:["latitude": String(stringInterpolationSegment: lastLocation.coordinate.latitude), "longitude": String(stringInterpolationSegment: lastLocation.coordinate.longitude)])
        }
    }
}

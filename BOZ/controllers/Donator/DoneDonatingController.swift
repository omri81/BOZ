//
//  DoneDonatingController.swift
//  OurHackathonDonation
//
//  Created by hackeru on 01/02/2018.
//  Copyright © 2018 Bar Arbiv. All rights reserved.
//
// used tutorial: https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class DoneDonatingController: UIViewController {
    var locationManager:CLLocationManager!
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var name: UITextField!
    
	@IBAction func done(_ sender: Any) {
		let userName = name.text!
		let alert = UIAlertController(title: "\(userName) תודה", message: "שליח יתקשר איתך בהקדם!", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(ok) in
			self.navigationController?.dismiss(animated: true, completion: nil)
		}))
		present(alert, animated: true, completion: nil)
	}
    private func isLocationPermissionGranted() -> Bool
    {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        return [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager() //initialize location manager
        locationManager.requestWhenInUseAuthorization()// prompt user current location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self //assign instance self as delegate property
        
        //map layer type
        mapView.mapType = .standard
        
        // uisearchcontroller:
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
    
        //searchbar:
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "הזן כתובת"
        navigationItem.titleView = resultSearchController?.searchBar
        
        // UISearchController appearance
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self        
    }
    
}
extension DoneDonatingController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: \(location)")
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        addressTV.text = "לא מצליח לאתר מיקום, רשום ידנית בבקשה"
        print("error: \(error)")
    }
    
}
extension DoneDonatingController: MKMapViewDelegate {
    //when user's location changed (walking, driving, etc..)
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //reset region to each location changed
        let newPlace = userLocation.coordinate
        let location = CLLocation(latitude: newPlace.latitude, longitude: newPlace.longitude)
        //print(location)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: nil) { (placemarks, error) in
            print(location)
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
            }
            
            if let count = placemarks?.count {
                if count > 0 {
                    let pm = placemarks![0]
                    if let name = pm.name {
                        var result = name
                        /*
                         if let street = pm.thoroughfare {
                         result += ", \(street)"
                         }
                         */
                        if let city = pm.locality {
                            result += ", \(city)"
                        }
                        /*
                         if let country = pm.country {
                         result += ", \(country)"
                         }*/
                        print("locality:")
                        print(result)
                        self.addressTV.text = result;
                    }
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            }
        }
        
    }
}

extension DoneDonatingController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let _ = placemark.locality,
            let _ = placemark.administrativeArea {
            annotation.subtitle = "\(String(describing: placemark.name!))"
            self.addressTV.text = placemark.name
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}


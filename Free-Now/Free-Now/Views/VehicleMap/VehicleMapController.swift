//
//  VehicleMapController.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import MapKit
import UIKit

protocol VehicleMapView: BaseView {
    
    func setCoordinateRegion(coordinateRegion: MKCoordinateRegion)
    func initialLocation(initialLocation: CLLocation)
    func addAnnotations(annotation: [MKAnnotation])
}

class VehicleMapController: BaseViewController {
    
    var presenter: VehicleMapPresenter<VehicleMapController>!
    var point1Latitude: Double?
    var point2Latitude: Double?
    var point1lLongitude: Double?
    var point2Longitude: Double?
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        presenter = VehicleMapPresenter(view: self)
        presenter.initialLocation()
        presenter.coordinateRegion()
        presenter.loadVehicle(p2latitude: 53.394655, p1longitude: 9.757589,
                              p1latitude: 53.694865, p2longitude: 10.099891)
    }
    
    func removeData() {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
    }
}

extension VehicleMapController: VehicleMapView {
    
    func initialLocation(initialLocation: CLLocation) {
        mapView.centerToLocation(initialLocation)
    }
    
    func setCoordinateRegion(coordinateRegion: MKCoordinateRegion) {
        mapView.region = coordinateRegion
    }
    
    func addAnnotations(annotation: [MKAnnotation]) {
        mapView.addAnnotations(annotation)
    }
}

extension VehicleMapController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        point2Latitude = mapView.centerCoordinate.latitude
        point2Longitude = mapView.centerCoordinate.longitude
        
        presenter.loadVehicle(p2latitude: point2Latitude ?? 53.394655, p1longitude: point1lLongitude ?? 9.757589,
                              p1latitude: point1Latitude ?? 53.694865, p2longitude: point2Longitude ?? 10.099891)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        point1Latitude = mapView.centerCoordinate.latitude
        point1lLongitude = mapView.centerCoordinate.longitude
        removeData()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("")
    }
}

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
    func removeAnnotations()
}

class VehicleMapViewController: BaseViewController {
    
    var presenter: VehicleMapPresenter<VehicleMapViewController>!
    
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
}

extension VehicleMapViewController: VehicleMapView {
    
    func initialLocation(initialLocation: CLLocation) {
        mapView.centerToLocation(initialLocation)
    }
    
    func setCoordinateRegion(coordinateRegion: MKCoordinateRegion) {
        mapView.region = coordinateRegion
    }
    
    func addAnnotations(annotation: [MKAnnotation]) {
        self.mapView.addAnnotations(annotation)
    }
    
    func removeAnnotations() {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
    }
}

extension VehicleMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let point1Coordinate = mapView.topLeftCoordinate()
        let point2Coordinate = mapView.bottomRightCoordinate()
        presenter.loadVehicle(p2latitude: point2Coordinate.latitude, p1longitude: point1Coordinate.longitude,
                              p1latitude: point1Coordinate.latitude, p2longitude: point2Coordinate.longitude)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        presenter.removeAnnotations()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier,
            for: annotation)
        annotationView.clusteringIdentifier = "identifier"
        annotationView.canShowCallout = true
        let button = UIButton(frame: CGRect(origin: .zero, size: .init(width: 30, height: 30)))
        button.setImage(#imageLiteral(resourceName: "Annotations/Car"), for: .normal)
        annotationView.rightCalloutAccessoryView = button
        return annotationView
    }
}

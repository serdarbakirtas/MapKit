//
//  VehicleMapPresenter.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import Foundation
import MapKit
import RxSwift

class VehicleMapPresenter<T: VehicleMapView>: BasePresenter<T> {
    
    // MARK: PROPERTIES
    let disposeBag = DisposeBag()
    let regionRadius: CLLocationDistance = 50000
    var items: [PoiList] = []
    var annotations = [MKAnnotation]()
    
    override init(view: T, apiInstance: FreeNowAPI = FreeNowAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
    
    // MARK: FUNCTIONS
    func initialLocation() {
        // Hamburg location is used as inital
        let initialLocation = CLLocation(latitude: 53.694865, longitude: 9.757589)
        view?.initialLocation(initialLocation: initialLocation)
    }
    
    func coordinateRegion() {
        // Hamburg location is used as inital
        let locationCenter = CLLocation(latitude: 53.394655, longitude: 10.099891)
        let coordinateRegion = MKCoordinateRegion(center: locationCenter.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        view?.setCoordinateRegion(coordinateRegion: coordinateRegion)
    }
    
    private func onVehiclesLoaded(vehicle: Vehicle) {
        guard let vehicleData = vehicle.poiList else { return }
        addVehicles(items: vehicleData)
    }
    
    private func addVehicles(items: [PoiList]) {
        for item in items {
            if !self.items.contains(where: { $0.id == item.id }) {
                self.items.append(item)
            }
        }
        addAnnotations()
    }
    
    private func addAnnotations() {
        for vehicleItem in items {
            let pin = VehiclePin(title: vehicleItem.state.rawValue, id: vehicleItem.id,
                                 coordinate: CLLocationCoordinate2D.init(
                                    latitude: vehicleItem.coordinate?.latitude ?? 0,
                                    longitude: vehicleItem.coordinate?.longitude ?? 0))
            annotations.append(pin)
        }
        view?.addAnnotations(annotation: annotations)
    }
    
    func removeAnnotations() {
        annotations.removeAll()
        items.removeAll()
        view?.removeAnnotations()
    }
    
    // MARK: API CALLS
    func loadVehicle(p2latitude: Double, p1longitude: Double, p1latitude: Double, p2longitude: Double) {
        apiInstance.getVehicleListWithLocation(p2latitude: p2latitude, p1longitude: p1longitude,
                                                    p1latitude: p1latitude, p2longitude: p2longitude)
        .applySchedulers()
        .showFullScreenActivityIndicator(view: view)
        .subscribe(onSuccess: { [unowned self] vehicle in
                    self.onVehiclesLoaded(vehicle: vehicle)},
                   onError: { [unowned self] error in
                    self.interpretError(title: "exampleLoadingError", error: error)
                    
        })
        .disposed(by: disposeBag)
    }
}

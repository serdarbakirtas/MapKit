//
//  VehicleListPresenter.swift
//
//  Created by Hasan on 15.10.20.
//

import Foundation
import RxSwift

class VehicleListPresenter<T: VehicleListView>: BasePresenter<T> {
    
    // MARK: PROPERTIES
    let disposeBag = DisposeBag()
    var items: [PoiList] = []
    var disposable: Disposable?
    
    override init(view: T, apiInstance: MapKitExampleAPI = MapKitExampleAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
    
    // MARK: FUNCTIONS
    func getVehicleListCount() -> Int {
        return items.count
    }
    
    func getVehicleListViewModel(index: Int) -> VehicleListViewModel {
        let item = items[index]
        return VehicleListViewModel(from: item)
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
    }
    
    private func removeAllVehicles() {
        items.removeAll()
    }
    
    // MARK: API CALLS
    func loadVehicle() {
        if disposable != nil {
            disposable?.dispose()
        }
        disposable = apiInstance.getVehicleList()
            .applySchedulers()
            .showFullScreenActivityIndicator(view: view)
            .do(onDispose: { [weak self] in self?.view?.reloadTable() })
            .subscribe(onSuccess: {[unowned self] vehicle in
                        self.onVehiclesLoaded(vehicle: vehicle)},
                       onError: {[unowned self] error in
                        self.interpretError(title: "exampleLoadingError", error: error)})
        disposable?.disposed(by: disposeBag)
    }
}

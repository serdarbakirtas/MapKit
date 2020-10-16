//
//  VehicleListPresenter.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import Foundation
import RxSwift

class VehicleListPresenter<T: VehicleListView>: BasePresenter<T> {
    
    // MARK: PROPERTIES
    let disposeBag = DisposeBag()
    let tableProperties = PaginatedTableProperties()
    var items: [PoiList] = []
    
    override init(view: T, shareApiInstance: FreeNowAPI = FreeNowAPIRepo.sharedInstance) {
        super.init(view: view, shareApiInstance: shareApiInstance)
    }
    
    // MARK: FUNCTIONS
    func getVehicleListCount() -> Int {
        return items.count
    }
    
    func getVehicleListViewModel(index: Int) -> VehicleListViewModel {
        let item = items[index]
        return VehicleListViewModel(from: item)
    }
    
    func getTableDescription() -> TableDescription {
        return TableDescription(singleDescription: "Vehicle")
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
        self.view?.reloadPaginatedTable()
    }
    
    // MARK: API CALLS
    func loadVehicle(page: Int) {
        shareApiInstance.getVehicleList(page: page, pageSize: FreeNowAPIRepo.UNLIMITED_PAGE_SIZE)
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

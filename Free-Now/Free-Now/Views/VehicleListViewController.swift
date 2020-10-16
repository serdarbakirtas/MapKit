//
//  VehicleListViewController.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import UIKit

protocol VehicleListView: BaseView, PaginatedTableDisplayer, SearchableTableDisplayer {}

class VehicleListViewController: BaseViewController {
    
    let searchBarTable = TableSearchBar()
    var searchDelegateHandler: TableSearchBarDelegateHandler!
    var presenter: VehicleListPresenter<VehicleListViewController>!
    
    @IBOutlet weak var tableVehicle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVehicle.register(UINib(nibName: "VehicleListCell", bundle: nil), forCellReuseIdentifier: "VehicleListCell")
        presenter = VehicleListPresenter(view: self)
        tableVehicle.delegate = self
        tableVehicle.dataSource = self
        setupPaginatedTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshTable()
    }
}

extension VehicleListViewController: VehicleListView {}

extension VehicleListViewController: SearchableTableDisplayer {
    
    var searchBar: UISearchBar {
        searchBarTable
    }
    
    var searchBarDelegateHandler: TableSearchBarDelegateHandler {
        searchDelegateHandler
    }
    
    func addSearchBarToTable() {
        searchBarTable.inject(to: view, with: tableView)
        searchDelegateHandler = TableSearchBarDelegateHandler(searchableTable: self)
    }
}

extension VehicleListViewController: PaginatedTableDisplayer {
    
    var tableProperties: PaginatedTableProperties {
        presenter.tableProperties
    }
    
    func loadItems(page: Int, section: Int, searchString: String) {
        presenter.loadVehicle(page: page)
    }
    
    var tableView: UITableView {
        tableVehicle
    }
    
    var tableDescription: TableDescription {
        presenter.getTableDescription()
    }
    
    func onRefresh() {
        refreshTable(withIndicator: true)
    }
}

extension VehicleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onTableViewWillDisplayCell(index: indexPath, cell: cell)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return getEstimatedHeightForRowAt(index: indexPath)
    }
}

extension VehicleListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getVehicleListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleListCell", for: indexPath)
            as? VehicleListCell else {
                return UITableViewCell()
        }
        
        let vehicleViewModel = presenter.getVehicleListViewModel(index: indexPath.row)
        cell.populateCell(with: vehicleViewModel)
        
        return cell
    }
}

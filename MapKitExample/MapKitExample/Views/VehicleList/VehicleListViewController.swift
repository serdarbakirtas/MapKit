//
//  VehicleListViewController.swift
//
//  Created by Hasan on 15.10.20.
//

import UIKit

protocol VehicleListView: BaseView {
    
    func reloadTable()
}

class VehicleListViewController: BaseViewController {
    
    var presenter: VehicleListPresenter<VehicleListViewController>!
    
    @IBOutlet weak var tableVehicle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVehicle.register(UINib(nibName: "VehicleListCell", bundle: nil), forCellReuseIdentifier: "VehicleListCell")
        tableVehicle.delegate = self
        tableVehicle.dataSource = self
        
        presenter = VehicleListPresenter(view: self)
        presenter.loadVehicle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension VehicleListViewController: VehicleListView {
    
    func reloadTable() {
        tableVehicle.reloadData()
    }
}

extension VehicleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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

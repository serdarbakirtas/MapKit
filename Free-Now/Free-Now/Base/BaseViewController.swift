//
//  BaseViewController.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import UIKit

protocol BaseView: BasePresenterView {
    func showFullScreenActivityIndicator(isShown: Bool)
}

protocol PermissionListener where Self: UIViewController {
    func onPermissionsChanged()
}

class BaseViewController: UIViewController {
    
    private var presenter: BaseViewPresenter<BaseViewController>!
    
    lazy var activityIndicatorForTables: UIActivityIndicatorView = {
        UIActivityIndicatorView(style: .gray)
    }()
    
    lazy var fullScreenActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.backgroundColor = .gray
        activityIndicator.color = .green
//        activityIndicator.pinToEdges(of: view)
        return activityIndicator
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = BaseViewPresenter(view: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showFullScreenActivityIndicator(isShown: false)
    }
    
    private func presentVC(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        if let presentedVC = self.presentedViewController {
            presentedVC.dismiss(animated: true) {
                self.present(viewController, animated: true)
            }
        } else {
            self.present(viewController, animated: true)
        }
    }
    
    private func pushVC(to navCont: UINavigationController, viewController: UIViewController) {
        if let presentedVC = navCont.presentedViewController {
            presentedVC.dismiss(animated: true) {
                navCont.pushViewController(viewController, animated: true)
            }
        } else {
            navCont.pushViewController(viewController, animated: true)
        }
    }
}

extension BaseViewController: BaseView {
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        }
        presentVC(viewController: alert)
    }
    
    func showFullScreenActivityIndicator(isShown: Bool) {
        if isShown {
            fullScreenActivityIndicator.startAnimating()
        } else {
            fullScreenActivityIndicator.stopAnimating()
        }
    }
}

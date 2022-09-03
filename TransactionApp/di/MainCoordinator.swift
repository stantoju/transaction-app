//
//  MainCoordinator.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import UIKit


class MainCoordinator: Coordinator {
    
    func launcherController() -> UIViewController{
        // Dependency sorting and injection for Initial viewController
        let persistence = Persistence(persistenceController: PersistenceController.shared)
        let repository = TransactionRepository(persistence: persistence)
        let usecase = TransactionUsecase(repository: repository)
        let viewmodel = TransactionViewmodel(usecase: usecase)
        let vc = TransactionController()
        vc.coordinator = self
        vc.viewModel = viewmodel
        vc.overrideUserInterfaceStyle = .light // Set light mode by default
        return vc
    }
    
    
    func openControllerAsModal<T>(originVC: UIViewController, destinationVC: ControllerType, data: T?) {
        let controller = destinationVC.controller(data: data)
        originVC.present(controller, animated: true)
    }
    
    
}


enum ControllerType {
    case deletion
    
    func controller<T>(data: T?) -> Coordinator.Coordinate {
        switch self {
        case .deletion:
            let vc = DeletionController()
            vc.data = data as? DeleteControllerData
            return vc
        }
    }
}

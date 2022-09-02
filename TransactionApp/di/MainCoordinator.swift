//
//  MainCoordinator.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import UIKit


class MainCoordinator: Coordinator {
    
    func launchController() -> UIViewController{
        // Dependency sorting and injection for Initial viewController
        let persistence = Persistence(persistenceController: PersistenceController.shared)
        let repository = TransactionRepository(persistence: persistence)
        let usecase = TransactionUsecase(repository: repository)
        let viewmodel = TransactionViewmodel(usecase: usecase)
        let vc = TransactionController()
        vc.viewModel = viewmodel
        vc.overrideUserInterfaceStyle = .light // Set light mode by default
        return vc
    }
    
    
}

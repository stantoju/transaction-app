//
//  Coordinator.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import Foundation
import UIKit

protocol Coordinator {
    typealias Coordinate =  UIViewController & Coordinating
    func launcherController() -> UIViewController
    func openControllerAsModal<T>(originVC: UIViewController, destinationVC: ControllerType, data: T?)
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
}

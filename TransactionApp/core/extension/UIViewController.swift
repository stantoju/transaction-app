//
//  UIViewController.swift
//  TransactionApp
//
//  Created by Toju on 9/2/22.
//

import UIKit


extension UIViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Dummy Data?", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDialogPrompt(topic: String? = "", message: String, yesString: String, noString: String,  yesAction: (() -> Void)?, noAction: (() -> Void)?) {
        let alert = UIAlertController(title: topic ?? "", message: message, preferredStyle: .alert)
        let yesButton = UIAlertAction(title: yesString, style: .default, handler: {(_ action: UIAlertAction) -> Void in
            yesAction?()
         })
         let cancelButton = UIAlertAction(title: noString, style: .default, handler: {(_ action: UIAlertAction) -> Void in
             noAction?()
         })
        alert.addAction(cancelButton)
         alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  UIView.swift
//  TransactionApp
//
//  Created by Toju on 9/1/22.
//

import UIKit


extension UIView {
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
      let tap = UITapGestureRecognizer(target: target, action: action)
      tap.numberOfTapsRequired = tapNumber
      addGestureRecognizer(tap)
      isUserInteractionEnabled = true
    }
    
    func addLongPressGesture(target: Any, action: Selector) {
      let longPress = UILongPressGestureRecognizer(target: target, action: action)
      addGestureRecognizer(longPress)
      isUserInteractionEnabled = true
    }
    
    func styleView(_ v: UIView, cornewRadius: CGFloat? = 20) {
        v.backgroundColor = .white
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.darkGray.cgColor
        v.layer.cornerRadius = cornewRadius ?? 20
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
    }
    
    
    func addSwipeGesture(target: Any, action: Selector) {
      let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = .down
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    
}

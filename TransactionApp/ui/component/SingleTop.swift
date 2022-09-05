//
//  SingleTop.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import UIKit

class SingleTop: UIView {
    
    var title: UILabel!
    var amount: UILabel!
    var vr: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        title = UILabel()
        title.text = "Income"
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        amount = UILabel()
        amount.text = "$0"
        amount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(amount)
        amount.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        amount.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        vr = UIView()
        vr.backgroundColor = .gray
        vr.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vr)
        vr.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        vr.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        vr.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        vr.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
    
    }
}


//
//  TopWidget.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import UIKit

class TopWidget: UIView {
    
    var container: UIView!
    var progressbar: UIProgressView!
    var hStack: UIStackView!
    var expense: SingleTop!
    var income: SingleTop!
    var balance: SingleTop!
    
    var statistics: Statistics? {
        didSet {
            mutateValue()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        expense = SingleTop()
        expense.title.text = "Expense"
        income = SingleTop()
        balance = SingleTop()
        balance.title.text = "Balance"
        
        
        hStack = UIStackView(arrangedSubviews: [expense, income, balance])
        hStack.distribution = .fillEqually
        hStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(hStack)
        hStack.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -50).isActive = true
        
        progressbar = UIProgressView()
        progressbar.progress = 0
        progressbar.tintColor = .darkGray
        progressbar.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(progressbar)
        progressbar.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        progressbar.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20).isActive = true
        progressbar.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 20).isActive = true
        progressbar.heightAnchor.constraint(equalToConstant: 10).isActive = true
        progressbar.layer.cornerRadius = 5
    
        
    }
    
    private func mutateValue() {
        guard let statistics = statistics else {
            return
        }
        // Convert Each to double and round off to 2 places decimal
        expense.amount.text = "$\(Double(statistics.expenses).rounded(toPlaces: 2))"
        income.amount.text = "$\(Double(statistics.income).rounded(toPlaces: 2))"
        balance.amount.text = "$\(Double(statistics.income - statistics.expenses).rounded(toPlaces: 2))"
        progressbar.progress = statistics.ratio
    }

}

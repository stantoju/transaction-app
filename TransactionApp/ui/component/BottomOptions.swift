//
//  BottomOptions.swift
//  TransactionApp
//
//  Created by Toju on 9/1/22.
//

import SwiftUI
import UIKit


class BottomOptions: UIView {
    
    var container: UIView!
    var vStack: UIStackView!
    var incomeButton: UIButton!
    var expenseButton: UIButton!
    var onSelectType: ((TransactionType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        container = UIView()
        container.backgroundColor = .white
        container.layer.borderWidth = 2
        container.layer.cornerRadius = 20
        container.layer.masksToBounds = true
        container.layer.borderColor = UIColor.darkGray.cgColor
        addSubview(container)
        container.frame = .init(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 180)
        
        incomeButton = UIButton()
        incomeButton.addTarget(self, action: #selector(ontapIncome), for: .touchUpInside)
        incomeButton.setTitle("Income", for: .normal)
        incomeButton.setTitleColor(.darkGray, for: .normal)
        incomeButton.backgroundColor = .white
        
        expenseButton = UIButton()
        expenseButton.addTarget(self, action: #selector(ontapExpense), for: .touchUpInside)
        expenseButton.setTitle("Expenses", for: .normal)
        expenseButton.setTitleColor(.darkGray, for: .normal)
        expenseButton.backgroundColor = .white
        
        vStack = UIStackView(arrangedSubviews: [incomeButton, expenseButton])
        vStack.axis = .vertical
        vStack.backgroundColor = .gray
        vStack.spacing = 1
        vStack.distribution =  .fillEqually
        vStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        vStack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant:  -30).isActive = true
        
        
        // Click on background to dismiss
        self.addTapGesture(tapNumber: 1, target: self, action: #selector(dismissView))
        
    }
    
    @objc private func ontapIncome() {
        onSelectType?(.income)
        animateOptions(false)
    }
    
    @objc private func ontapExpense() {
        onSelectType?(.expenses)
        animateOptions(false)
    }
    
    @objc private func dismissView() {
        animateOptions(false)
    }
    
    func animateOptions(_ showUp: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            if showUp {
                self.container.frame = .init(x: 0, y: UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width, height: 180)
            } else {
                self.container.frame = .init(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 180)
            }
        } completion: { _ in
            if !showUp {
                self.removeFromSuperview()
            }
        }
        layoutIfNeeded()
    }
    
    
}



// MARK: - Canvas Previews with SwiftUI
struct DropOption_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            BottomOptions()
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
        
        typealias UIViewType = UIView
        
    }
}


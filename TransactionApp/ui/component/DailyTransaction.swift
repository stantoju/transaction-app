//
//  DailyTransaction.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import Foundation

import UIKit
import SwiftUI


class DailyTransaction: UITableViewCell {
    
    static let identifier = "\(DailyTransaction.self)"
    var container: UIStackView!
    var transactions: GroupedTransaction? {
        didSet {
            processContent()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        
        container = UIStackView()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.layer.borderWidth = 1
        container.layer.masksToBounds = true 
        container.layer.borderColor = UIColor.darkGray.cgColor
        container.layer.cornerRadius = 20
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    
    
    private func processContent(){
        // Clear container
        container.subviews.forEach {
            container.removeArrangedSubview($0)
          $0.removeFromSuperview()
        }
        
        container.distribution = .fillEqually
//       Add date label
        let dateCell = SingleCell()
        dateCell.translatesAutoresizingMaskIntoConstraints = false
        dateCell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateCell.setHeader(header: transactions?.date ?? "")
        container.addArrangedSubview(dateCell)
        
        // Loop through and add transactions
        for item in transactions!.content {
            let singleCell = SingleCell()
            singleCell.transaction = item
            singleCell.translatesAutoresizingMaskIntoConstraints = false
            singleCell.heightAnchor.constraint(equalToConstant: 50).isActive = true
            singleCell.setConent(item)
            container.addArrangedSubview(singleCell)
        }
    }

}



// MARK: - Canvas Previews with SwiftUI
struct DailyTransaction_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            SingleCell()
//            DailyTransaction()
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
        
        typealias UIViewType = UIView
        
    }
}



class SingleCell: UITableViewCell {
    
    static let identifier = "\(SingleCell.self)"
    var title: UILabel!
    var amount: UILabel!
    var hr: UIView!
    var transaction: Transaction?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func  setupView(){
        title = UILabel()
        title.text = "Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        amount = UILabel()
        amount.text = "$300"
        amount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(amount)
        amount.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        amount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        hr = UIView()
        hr.translatesAutoresizingMaskIntoConstraints = false
        hr.backgroundColor = .darkGray
        addSubview(hr)
        hr.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        hr.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        hr.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        hr.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    func setHeader(header: String) {
        title.text = header
        amount.isHidden = true
    }
    
    func setConent(_ _transaction: Transaction?) {
        guard let item = _transaction else { return }
        let value = Double(item.amount).rounded(toPlaces: 2)
        title.text = item.title
        switch item.type {
        case .income:
            amount.text = "$\(value)"
        case .expenses:
            amount.text = "-$\(value)"
        }
    }
}

//
//  EntryModal.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//


import UIKit
import Combine

class EntryModal: UIView {
    
    var container: UIView!
    var title: UILabel!
    var vr: UIView!
    var transactionTypeLabel: UILabel!
    var typeCaretButton: UIButton!
    var descriptionField: UITextField!
    var amountField: UITextField!
    var dollarLabel: UILabel!
    var amountControl: UIStackView!
    var addButton: UIButton!
    var bottomOptions: BottomOptions!
    var closeButton: UIButton!
    
    var createTransaction: ((Transaction) -> Void)?
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var _type: TransactionType!
    @Published var _description = ""
    @Published var _amount: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        backgroundColor = .black.withAlphaComponent(0.5)
        setupListener()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        
        container = UIView()
        styleView(container)
        addSubview(container)
        container.tag = 22
        container.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        container.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        title = UILabel()
        title.text = "Add Transaction"
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(title)
        title.topAnchor.constraint(equalTo: container.topAnchor, constant: 40).isActive = true
        title.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        transactionTypeLabel = UILabel()
        transactionTypeLabel.addTapGesture(tapNumber: 1, target: self, action: #selector(onTapTransactionType))
        styleView(transactionTypeLabel, cornewRadius: 10)
        transactionTypeLabel.textAlignment = .center
        transactionTypeLabel.text = "Transaction Type"
        container.addSubview(transactionTypeLabel)
        transactionTypeLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        transactionTypeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant:  20).isActive = true
        transactionTypeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant:  -20).isActive = true
        transactionTypeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        typeCaretButton = UIButton()
        typeCaretButton.addTarget(self, action: #selector(onTapTransactionType), for: .touchUpInside)
        typeCaretButton.backgroundColor = .lightGray
        typeCaretButton.tintColor = .gray
        typeCaretButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        typeCaretButton.translatesAutoresizingMaskIntoConstraints = false
        transactionTypeLabel.addSubview(typeCaretButton)
        typeCaretButton.trailingAnchor.constraint(equalTo: transactionTypeLabel.trailingAnchor).isActive = true
        typeCaretButton.topAnchor.constraint(equalTo: transactionTypeLabel.topAnchor).isActive = true
        typeCaretButton.bottomAnchor.constraint(equalTo: transactionTypeLabel.bottomAnchor).isActive = true
        typeCaretButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionField = UITextField()
        descriptionField.delegate = self
        descriptionField.tag = 7
        descriptionField.placeholder = "Transaction Description"
        styleView(descriptionField, cornewRadius: 10)
        container.addSubview(descriptionField)
        descriptionField.topAnchor.constraint(equalTo: transactionTypeLabel.bottomAnchor, constant: 20).isActive = true
        descriptionField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant:  20).isActive = true
        descriptionField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant:  -20).isActive = true
        descriptionField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // padding
        let descriptionFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.descriptionField.frame.height))
        descriptionField.leftView = descriptionFieldPadding
        descriptionField.leftViewMode = .always
        
        
        amountField = UITextField()
        amountField.tag = 5
        amountField.keyboardType = .numberPad
        amountField.delegate = self
        styleView(amountField, cornewRadius: 10)
        container.addSubview(amountField)
        amountField.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20).isActive = true
        amountField.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        amountField.widthAnchor.constraint(equalToConstant: 120).isActive = true
        amountField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // padding
        let amountFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.descriptionField.frame.height))
        amountField.leftView = amountFieldPadding
        amountField.leftViewMode = .always
        
        dollarLabel = UILabel()
        dollarLabel.translatesAutoresizingMaskIntoConstraints = false
        dollarLabel.textAlignment = .center
        dollarLabel.text = "$"
        amountField.addSubview(dollarLabel)
        dollarLabel.topAnchor.constraint(equalTo: amountField.topAnchor).isActive = true
        dollarLabel.bottomAnchor.constraint(equalTo: amountField.bottomAnchor).isActive = true
        dollarLabel.leadingAnchor.constraint(equalTo: amountField.leadingAnchor).isActive = true
        dollarLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let upButton = UIButton()
        upButton.tag = 0
        upButton.addTarget(self, action: #selector(onTapAmountButton(_:)), for: .touchUpInside)
        upButton.imageView?.contentMode = .center
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        upButton.backgroundColor = .lightGray
        upButton.tintColor = .gray
        
        let downButton = UIButton()
        downButton.tag = 1
        downButton.addTarget(self, action: #selector(onTapAmountButton(_:)), for: .touchUpInside)
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        downButton.backgroundColor = .lightGray
        downButton.tintColor = .gray
        
        amountControl = UIStackView()
        amountControl.addArrangedSubview(upButton)
        amountControl.addArrangedSubview(downButton)
        amountControl.distribution = .fillEqually
        amountControl.axis = .vertical
        amountControl.translatesAutoresizingMaskIntoConstraints = false
        amountField.addSubview(amountControl)
        amountControl.topAnchor.constraint(equalTo: amountField.topAnchor).isActive = true
        amountControl.bottomAnchor.constraint(equalTo: amountField.bottomAnchor).isActive = true
        amountControl.trailingAnchor.constraint(equalTo: amountField.trailingAnchor).isActive = true
        amountControl.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addButton = UIButton()
        addButton.addTarget(self, action: #selector(onTapAddButton), for: .touchUpInside)
        addButton.isEnabled = false
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.gray, for: .normal)
        styleView(addButton, cornewRadius: 10)
        addButton.backgroundColor = .lightGray
        container.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 24).isActive = true
        addButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.contentMode =  .scaleAspectFill
        closeButton.backgroundColor = .white
        closeButton.layer.borderColor = UIColor.darkGray.cgColor
        closeButton.layer.borderWidth = 2
        closeButton.layer.cornerRadius = 15
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        closeButton.layer.borderColor = UIColor.darkGray.cgColor
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        // Click on background to dismiss
        closeButton.addTapGesture(tapNumber: 1, target: self, action: #selector(dismissView))
    }
    
    private func showBottomOption(){
        bottomOptions = BottomOptions()
        bottomOptions.onSelectType = onSelectType
        addSubview(bottomOptions)
        bottomOptions.frame = frame
        bottomOptions.animateOptions(true)
    }
    
    @objc func onTapAddButton() {
        let transaction = Transaction(id: UUID(), title: _description, type: _type, amount: Float(_amount), date: Date())
        createTransaction?(transaction)
    }
    
    @objc func onTapTransactionType() {
        showBottomOption()
    }
    
    // Handle Amount increase
    @objc func onTapAmountButton(_ button: UIButton) {
        if button.tag == 0 {
            _amount += 1
        } else if button.tag == 1 {
            if _amount > 0 {
                _amount -= 1
            }
        }
    }
    
    // Transaction type selector handler
    func onSelectType(_ type: TransactionType) {
        switch type {
        case .income:
            transactionTypeLabel.text = "Income"
            _type = .income
        case .expenses:
            transactionTypeLabel.text = "Expenses"
            _type = .expenses
        }
    }
    
    func setupListener() {
        $_amount.sink { [weak self] amt in
            self?.amountField.text = String(amt)
            }.store(in: &cancellables)
        
        // Check if all fields are valid and enable or disable the add button, depending on result
        Publishers.CombineLatest3($_amount, $_type, $_description).sink { [weak self] (amt, typ, desc) in
            
            if amt > 0 && typ != nil  && !desc.isEmpty {
                self?.addButton.isEnabled = true
                self?.addButton.setTitleColor(.black, for: .normal)
            } else {
                self?.addButton.isEnabled = false
                self?.addButton.setTitleColor(.gray, for: .normal)
            }
        }.store(in: &cancellables)
        
    }
    
    @objc private func dismissView() {
            self.removeFromSuperview()
    }
    
    
    
}



// Delegates for DescriptionField
extension EntryModal: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 5 {
            _amount = Int(textField.text ?? "0") ?? 0
        } else if textField.tag == 7 {
            _description = textField.text ?? ""
        }
        return true
    }
}



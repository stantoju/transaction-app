//
//  ViewController.swift
//  TransactionApp
//
//  Created by Toju on 8/29/22.
//

import UIKit
import SwiftUI
import Combine

class TransactionController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    var viewModel: TransactionViewmodel?
    var topWidget: TopWidget!
    var floatingButton: UIButton!
    var transactionTable: UITableView!
    var entryModal: EntryModal!
    private var cancellables: Set<AnyCancellable> = []
    var transactionToDelete: Transaction!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupView()
        transactionTable.register(DailyTransaction.self, forCellReuseIdentifier: DailyTransaction.identifier)
        transactionTable.dataSource = self
        transactionTable.delegate = self
        transactionTable.estimatedRowHeight = 200
        
        setupListener()
        
        // Swipe down to dismiss keyboard
        view.addSwipeGesture(target: self, action: #selector(dismissKeyboard))
        
        viewModel?.getTransactions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert("Hold down the Floating Button ( + ) for few seconds to populate dummy data")
    }

    
    fileprivate func setupView(){
        topWidget = TopWidget()
        topWidget.translatesAutoresizingMaskIntoConstraints = false
        topWidget.layer.borderColor = UIColor.darkGray.cgColor
        topWidget.layer.borderWidth = 1
        topWidget.layer.cornerRadius = 20
        view.addSubview(topWidget)
        topWidget.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topWidget.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        topWidget.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        topWidget.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        transactionTable = UITableView()
        transactionTable.showsVerticalScrollIndicator = false
        transactionTable.autoresizingMask = [.flexibleHeight]
        transactionTable.rowHeight = UITableView.automaticDimension
        transactionTable.estimatedRowHeight = 180
        transactionTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionTable)
        transactionTable.topAnchor.constraint(equalTo: topWidget.bottomAnchor, constant: 10).isActive = true
        transactionTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        transactionTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        transactionTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        floatingButton = UIButton()
        floatingButton.addTapGesture(tapNumber: 1, target: self, action: #selector(showModal))
        floatingButton.addLongPressGesture(target: self, action: #selector(loadDummyData))
        floatingButton.backgroundColor = .white
        floatingButton.layer.borderColor = UIColor.darkGray.cgColor
        floatingButton.layer.borderWidth = 2
        floatingButton.layer.cornerRadius = 30
        floatingButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        floatingButton.tintColor = .darkGray
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingButton)
        floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        floatingButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    private func setupListener() {
        viewModel?.$transactions.sink { [weak self] transactions in
            self?.transactionTable.reloadData()
            }.store(in: &cancellables)
        
        
        viewModel?.$statistics.sink { [weak self] stats in
            self?.modifyStatistics(stats)
            }.store(in: &cancellables)

        
        viewModel?.$saved.sink { [weak self] s in
            if s {
                self?.dismissModal()
            }
            }.store(in: &cancellables)
    }
    
    @objc private func showModal(){
        entryModal = EntryModal()
        entryModal.createTransaction = createTransaction
        view.addSubview(entryModal)
        entryModal.frame = view.frame
    }
    
    
    @objc private func loadDummyData() {
        viewModel?.populateDummyData()
    }
    
    @objc private func dismissModal() {
        entryModal.removeFromSuperview()
    }
    
    // Note: Keyboard is dismissed onswipe down
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createTransaction(_ transaction: Transaction) {
        viewModel?.saveTransaction(transaction)
    }
    
    func modifyStatistics(_ stats: Statistics) {
        topWidget.statistics = stats
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        viewModel?.deleteTransaction(transaction)
    }
    
    func lauchDeleteModal(_ groupedTransaction: GroupedTransaction) {
        let data = DeleteControllerData(groupedTransaction: groupedTransaction, action: deleteTransaction) // Prepare data value to be passed
        coordinator?.openControllerAsModal(originVC: self, destinationVC: .deletion, data: data)
    }
    
    
}

extension TransactionController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTransaction.identifier, for: indexPath) as! DailyTransaction
        let groupTransaction = viewModel?.transactions[indexPath.item]
        cell.transactions = groupTransaction
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let transaction = viewModel?.transactions[indexPath.item] else { return  }
        lauchDeleteModal(transaction)
    }
    
}



// MARK: - Canvas Previews with SwiftUI
struct TransactionController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            TransactionController()
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context)  {
            
        }
        
        typealias UIViewControllerType = UIViewController
        
        
    }
}


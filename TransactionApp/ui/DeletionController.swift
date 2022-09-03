//
//  DeletionController.swift
//  TransactionApp
//
//  Created by Toju on 9/3/22.
//


import UIKit
import SwiftUI

class DeletionController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var dateLabel: UILabel!
    var infoLabel: UILabel!
    var transactionTable: UITableView!
    var data: DeleteControllerData?
    var deleteTransaction: ((Transaction) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        transactionTable.register(SingleCell.self, forCellReuseIdentifier: SingleCell.identifier)
        transactionTable.delegate = self
        transactionTable.dataSource = self
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = data?.groupedTransaction.date
    }

    
    fileprivate func setupView(){
        
        dateLabel = UILabel()
        dateLabel.text = "July 25, 2020"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        infoLabel = UILabel()
        infoLabel.text = "Swipe left on a transaction item to delete it"
        infoLabel.font = .systemFont(ofSize: 13, weight: .light)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        transactionTable = UITableView()
        transactionTable.showsVerticalScrollIndicator = false
        transactionTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionTable)
        transactionTable.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20).isActive = true
        transactionTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        transactionTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        transactionTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

    }
    
    private func populateData(_ parsedData: DeleteControllerData) {
        data = parsedData
    }
    
}

extension DeletionController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.groupedTransaction.content.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleCell.identifier, for: indexPath) as! SingleCell
        let transaction = data?.groupedTransaction.content[indexPath.item]
        cell.transaction = transaction
        cell.setConent(transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard var content = data?.groupedTransaction.content else { return }
            data?.action?(content[indexPath.item]) // Delete from DB action
            content.remove(at: indexPath.row) // remove the item from the data model
            data?.groupedTransaction.content = content // Replace  data content
            tableView.deleteRows(at: [indexPath], with: .fade)// delete the table view row
            data?.groupedTransaction.content = content // Replace  data content
            tableView.reloadData() // Refresh table
                }
    }
}



// MARK: - Canvas Previews with SwiftUI
struct DeletionController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            DeletionController()
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context)  {
            
        }
        
        typealias UIViewControllerType = UIViewController
        
        
    }
}



struct DeleteControllerData {
    var groupedTransaction: GroupedTransaction
    var action: ((Transaction) -> Void)?
}

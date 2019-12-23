//
//  ViewController.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit


class FactsViewController: UIViewController {
    
    private var countryInfo: CountryInfo!
    private var viewModel: CountryViewModel!

    enum Height {
        static let estimated: CGFloat = 100
    }
    enum Message {
        static let initialLoading = "Please wait..."
    }
    
    //MARK:- Programatically UITableView creation
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = Height.estimated
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()

    lazy var messageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 21)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpEmptyOrErrorLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = CountryViewModel(delegate: self)
        viewModel.fetchAPI()
        viewModel.updateNavigationTitle = { [weak self] () in
            self?.title = self?.viewModel.countryTitle
        }

    }
    

}

//MARK:-   UI Setup
extension FactsViewController {
    func setupTableView() {
        tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: FactsTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setUpEmptyOrErrorLabel() {
        tableView.backgroundView = messageLabel
        messageLabel.text = Message.initialLoading
    }

}

// MARK: UITableViewDataSource
extension FactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryInfo?.facts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FactsTableViewCell.identifier) as? FactsTableViewCell else {
            fatalError(" Please check TableViewCell identifier")
        }
        let _ = countryInfo.facts?[indexPath.row]
        return cell
    }
}

// MARK: Callback on getting response
extension FactsViewController: CallbacklDelegate {
    func onFetchCompleted(with result: CountryInfo) {
        countryInfo = result
        print(countryInfo)
        tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
    }
}

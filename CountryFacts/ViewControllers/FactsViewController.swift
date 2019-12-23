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
    private var refreshControl: UIRefreshControl!

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
        setRrefreshControl()
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
        
        //hide the refreshControl, on response received
        viewModel.updateRefreshControl = { [weak self] () in
            guard
                let refreshControl = self?.refreshControl,
                refreshControl.isRefreshing else { return }
            refreshControl.endRefreshing()
        }
    }

}

//MARK:-   UI Setup
extension FactsViewController {
    func setupTableView() {
        tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: FactsTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.refreshControl = refreshControl

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
    
    private func setRrefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching")
        refreshControl.tintColor = .white
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        viewModel.fetchAPI()
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
        let factsInfo = countryInfo.facts?[indexPath.row]
        cell.facts = factsInfo
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: Callback on getting response
extension FactsViewController: CallbacklDelegate {
    func onFetchCompleted(with result: CountryInfo) {
        countryInfo = result
        tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        tableView.backgroundView = messageLabel
        messageLabel.text = reason
    }
}

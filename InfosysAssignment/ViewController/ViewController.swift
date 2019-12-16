//
//  ViewController.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// Facts list view object
    var factsTableView: UITableView!

    /// Facts list/tableview's cell reusable identifier
    let cellId = "FactTableViewCell"

    /// Data refresher UI object
    var dataRefresher: UIRefreshControl!

    // Create data model object
    let viewControllerViewModel = ViewControllerViewModel()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup
        setup()

        // Get initial facts data
        viewControllerViewModel.getFactsData()
        viewControllerViewModel.onDataHandler = { (result) in
            if let lResult = result {
                switch lResult {
                case .success(let value):
                    if let lFactResponse = value as? FactResponse {
                        DispatchQueue.main.async {
                            self.title = lFactResponse.title
                            self.reloadData()
                        }
                    }
                default:
                    break
                }
            }
        }
    }
}

extension ViewController {
    ///
    /// Call this function to setup the initial layout on the top most `view` object
    ///
    func setup() {
        if factsTableView == nil {
            // Create facts table/list view object
            factsTableView = UITableView(frame: view.bounds, style: .plain)
            factsTableView.delegate = self
            factsTableView.dataSource = self
            factsTableView.rowHeight = UITableView.automaticDimension
            factsTableView.estimatedRowHeight = UITableView.automaticDimension
            factsTableView.isHidden = true
            view.addSubview(factsTableView)

            // Constraints for factsTableView object
            factsTableView.translatesAutoresizingMaskIntoConstraints = false
            factsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 0).isActive = true
            factsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: 0).isActive = true
            factsTableView.topAnchor.constraint(equalTo: view.topAnchor,
                                                constant: 0).isActive = true
            factsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                   constant: 0).isActive = true
        }

        if dataRefresher == nil {
            // Crete refresh control to refresh the facts data
            dataRefresher = UIRefreshControl()
            dataRefresher.addTarget(self, action: #selector(refreshFactsData), for: .valueChanged)
            factsTableView.addSubview(dataRefresher)
        }
    }

    ///
    /// Call this function to reload the facts list data
    ///
    func reloadData() {
        self.factsTableView?.reloadData()
        self.factsTableView?.layoutIfNeeded()
        // For smooth content reload
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.factsTableView?.reloadData()
            self.factsTableView.isHidden = false
        }
    }

    ///
    /// Will trigers the refresh facts completion block
    ///
    @objc func refreshFactsData() {
        viewControllerViewModel.getFactsData()
    }

    ///
    /// Configures the `FactTableViewCell` cell object
    /// - Parameter cell: Pass the `FactTableViewCell`cell object to configure and show the data
    /// - Parameter indexPath: Current cell indexpath
    ///
    func configureCell(cell: FactTableViewCell, at indexPath: IndexPath) {
        cell.setData(fact: viewControllerViewModel.facts[indexPath.row], at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewControllerViewModel.facts.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Check for reusable cell object, if not exists create tableview cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? FactTableViewCell else {
            let cell = FactTableViewCell(style: .default, reuseIdentifier: cellId)
            return cell
        }
        // Return reusing cell object
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FactTableViewCell else { return }
        // Configure or set cell data
        configureCell(cell: cell, at: indexPath)
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

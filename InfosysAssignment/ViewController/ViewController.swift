//
//  ViewController.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // View model object for facts list view
    var factsTableViewModel: FactTableViewModel!

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create data model object for facts tableview
        let lFactsTableViewModel = FactTableViewModel(sourceView: view)
        view.addSubview(lFactsTableViewModel.factsTableView)
        factsTableViewModel = lFactsTableViewModel

        /// Registrer refresh action
        factsTableViewModel.onRefresh = {
            self.getFactsData()
        }

        // Get initial facts data
        getFactsData()
    }
}

extension ViewController {
    func getFactsData() {
        // Check for internet connectivity
        if NetworkConnection.isConnectedToNetwork() {
            let urlPath = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
            sendGetRequest(url: urlPath,
                           mapTo: FactResponse.self) { [weak self](result) in
                            switch result {
                            case .error(let error):
                                // If there is any error then tell the user
                                DispatchQueue.main.async {
                                    self?.factsTableViewModel.dataRefresher.endRefreshing()
                                    self?.showAlert(title: NSLocalizedString("Error", comment: ""),
                                                   message: NSLocalizedString(error.localizedDescription, comment: ""),
                                                   from: self!)
                                }
                            case .success(let value):
                                // Remove already existed object if it is the first page.
                                // This logic will be changed if the are multiple pages
                                DispatchQueue.main.async {
                                    self?.factsTableViewModel.facts.removeAll()
                                    if let lValue = value as? FactResponse {
                                        self?.factsTableViewModel.facts.append(contentsOf: lValue.rows)
                                        self?.title = lValue.title
                                    }
                                    self?.factsTableViewModel.dataRefresher.endRefreshing()
                                    self?.factsTableViewModel.reloadData()
                                }
                            }
            }
        } else {
            // Show no internet connection error
            DispatchQueue.main.async {
                self.showAlert(title: NSLocalizedString("Network Error", comment: ""),
                               message: NSLocalizedString("The internet connection appears to be offline.",
                                                          comment: ""),
                               from: self)
            }
        }
    }
}

extension ViewController: APIRestClient {}

extension ViewController: Alerts {}

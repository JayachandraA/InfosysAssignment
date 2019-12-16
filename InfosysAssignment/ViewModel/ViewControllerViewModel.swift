//
//  ViewControllerViewModel.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class ViewControllerViewModel: NSObject {

    /// Facts list view data
    var facts = [Fact]()

    // Data handler to handle the view updates
    var onDataHandler: ((APIRestClientResult?) -> Void)?

    override init() {
        super.init()
    }

    func getFactsData() {
        // Check for internet connectivity
        if NetworkConnection.isConnectedToNetwork() {
            let urlPath = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
            sendGetRequest(url: urlPath,
                           mapTo: FactResponse.self) { [weak self](result) in
                            switch result {
                            case .error(let error):
                                self?.showAlert(title: NSLocalizedString("Facts Error", comment: ""),
                                               message: NSLocalizedString(error.localizedDescription,
                                                                          comment: ""))
                            case .success(let value):
                                if let lValue = value as? FactResponse {
                                    self?.facts.removeAll()
                                    self?.facts.append(contentsOf: lValue.rows)
                                    if let handler = self?.onDataHandler {
                                        handler(result)
                                    }
                                }
                            }
            }
        } else {
            if let handler = onDataHandler {
                handler(nil)
            }
            // Show no internet connection error
            DispatchQueue.main.async {
                self.showAlert(title: NSLocalizedString("Network Error", comment: ""),
                               message: NSLocalizedString("The internet connection appears to be offline.",
                                                          comment: ""))
            }
        }
    }
}

extension ViewControllerViewModel: APIRestClient {}

extension ViewControllerViewModel: Alerts {}

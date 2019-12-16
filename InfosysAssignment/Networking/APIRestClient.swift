//
//  APIRestClient.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import Foundation

enum APIRestClientResult {
    case error(Error)
    case success(Any)
}

protocol APIRestClient {
}

extension APIRestClient {
    func sendGetRequest<T>(url: String,
                           mapTo: T.Type,
                           completionHandler:@escaping (APIRestClientResult) -> Void) where T: Codable {
        // To get form local file
        //guard let requestUrl = Bundle.main.url(forResource: "local_data", withExtension: "json") else { return }
         guard let requestUrl = URL(string: url) else {
             fatalError("\(#function),\(url) url is not valid.")
         }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: requestUrl) { (data, _, error) in
            if let lData = data {
                do {
                    // Debug prints
                    // print(lData) (from server 3107 bytes) (from local 3453 bytes)
                    if let jsonStr = String(data: lData, encoding: .ascii) {
                        // Debug prints
                        // print("jsonStr \(jsonStr)")
                        if let jsonData = jsonStr.data(using: .utf8) {
                            let object = try JSONDecoder().decode(T.self, from: jsonData)
                            completionHandler(.success(object))
                        } else {
                            let unknownError = NSError(domain: "api.restclient.error",
                                                       code: 0,
                                                       userInfo: [NSLocalizedDescriptionKey:
                                                        "Response received for \(url) is not a valid json object"])
                            completionHandler(.error(unknownError))
                        }
                    } else {
                        let unknownError = NSError(domain: "api.restclient.error",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey:
                            "Response received for \(url) is not a valid json object"])
                        completionHandler(.error(unknownError))
                    }
                } catch let parsingError {
                    // Debug prints
                    // print(parsingError)
                    completionHandler(.error(parsingError))
                }
            } else if let lError = error {
                completionHandler(.error(lError))
            } else {
                let unknownError = NSError(domain: "api.restclient.error",
                                           code: 0,
                                           userInfo: [NSLocalizedDescriptionKey: "Can't send request to \(url)"])
                completionHandler(.error(unknownError))
            }
        }
        dataTask.resume()
    }
}

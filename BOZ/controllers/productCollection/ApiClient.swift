//
//  ApiClient.swift
//  BOZ
//
//  Created by user134028 on 2/23/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation

typealias MilkSubstJSON = [String: Any]

struct APIClient {
    
    static func getMilkSubstsAPI(completion: @escaping (MilkSubstJSON?) -> Void) {
        
        let url = URL(string: "https://api.myjson.com/bins/ly2qd")
        
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? MilkSubstJSON
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}

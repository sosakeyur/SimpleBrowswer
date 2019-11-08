//
//  NetworkManager.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/16/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

import UIKit

var baseURL = "https://api.bing.com/osjson.aspx?query="
var basewebURL = "https://www.bing.com/search?q="

class NetworkManager {
    private let session = URLSession.shared

    func fetchSearchResult(searchQuery: String, completion: @escaping (_ result: Any?, _ error: Error?) -> Void) {
        let finalurl = URL(string: baseURL + searchQuery)
        guard let url = finalurl else { return }
        session.dataTask(with: url) { data, _, _ in
            guard let responseData = data else { return }
            let json = try? JSONSerialization.jsonObject(with: responseData, options: [])
            completion(json, nil)
        }.resume()
    }
}

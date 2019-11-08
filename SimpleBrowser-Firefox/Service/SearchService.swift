//
//  SearchService.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/16/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

public struct SearchService {
    public static let service = SearchService()

    private let networkManager = NetworkManager()
}

extension SearchService {
    func fetchSearchResult(searchQuery: String, completion: @escaping (_ result: Any?, _ error: Error?) -> Void) {
        networkManager.fetchSearchResult(searchQuery: searchQuery, completion: completion)
    }
}

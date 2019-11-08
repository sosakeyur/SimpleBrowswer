//
//  SearchInteractor.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/16/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

struct SearchInteractor: SearchInterfaces {
    private let presenter: SearchPresentable
    private let service = SearchService()

    init(presenter: SearchPresentable) {
        self.presenter = presenter
    }
}

extension SearchInteractor {
    func fetchSearchResult(searchQuery: String) {
        service.fetchSearchResult(searchQuery: searchQuery) { response, error in

            guard error == nil else {
                return self.presenter.presentFetched(error: error)
            }

            guard let responseArray = response as? [Any],
                let first = responseArray.first as? String,
                let last = responseArray.last as? [String] else {
                return
            }

            print(first)
            print(last)

            let response = SearchViewModel.Response(seacrhResult: last)
            self.presenter.presentFetched(for: response)
        }
    }
}

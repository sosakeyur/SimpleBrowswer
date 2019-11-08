//
//  SearchInterfaces.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/17/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

protocol SearchInterfaces {
    func fetchSearchResult(searchQuery: String)
}

protocol SearchPresentable {
    func presentFetched(for response: SearchViewModel.Response)
    func presentFetched(error: Error?)
}

protocol SearchDisplayable: class { // Controller
    func displayFetched(with viewModel: SearchViewModel.Response)
    func displayFetched(with error: String)
}

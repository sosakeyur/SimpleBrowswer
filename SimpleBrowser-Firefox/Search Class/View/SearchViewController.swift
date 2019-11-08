//
//  SearchViewController.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/16/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Scene variables

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var containerView: UIView!
    var containerViewController: EmbededWebView?
    private lazy var interactor: SearchInterfaces = SearchInteractor(
        presenter: SearchPresenter(viewController: self)
    )

    // MARK: - Internal variables

    private var searchData: SearchViewModel.Response?

    // MARK: - Controller cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(searchBarText: "")
    }

    @IBAction func clearSearchBar(_ sender: Any) {
        searchBar.text = ""
    }
}

// MARK: - Events

private extension SearchViewController {
    func configure() {
        showHideController(isContainerHidden: true, isTableViewHidden: false)
        tableView.tableFooterView = UIView(frame: .zero)
        registerForKeyboardWillShowNotification(tableView)
        registerForKeyboardWillHideNotification(tableView)

        /* use the above functions with
         block, in case you want the trigger just after the keyboard
         hide or show which will return you the keyboard size also.
         */

        registerForKeyboardWillShowNotification(tableView) { keyboardSize in
            print("size 1 - \(keyboardSize!)")
        }
        registerForKeyboardWillHideNotification(tableView) { keyboardSize in
            print("size 2 - \(keyboardSize!)")
        }
    }

    func loadData(searchBarText: String) {
        interactor.fetchSearchResult(searchQuery: searchBarText)
    }

    func showHideController(isContainerHidden: Bool, isTableViewHidden: Bool) {
        containerView.isHidden = isContainerHidden
        tableView.isHidden = isTableViewHidden
    }
}

// MARK: - Scene cycle

extension SearchViewController: SearchDisplayable {
    func displayFetched(with viewModel: SearchViewModel.Response) {
        searchData = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayFetched(with error: String) {
        // create the alert
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Search Delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData(searchBarText: searchText)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        showHideController(isContainerHidden: true, isTableViewHidden: false)
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

// MARK: - Delegates

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData?.seacrhResult.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = searchData?.seacrhResult[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let embededWebView = children.last as! EmbededWebView
        embededWebView.loadWebView(url: basewebURL + (searchData?.seacrhResult[indexPath.row] ?? ""))
        showHideController(isContainerHidden: false, isTableViewHidden: true)
        searchBar.text = (searchData?.seacrhResult[indexPath.row] ?? "")
        searchBar.searchTextField.resignFirstResponder()
    }
}

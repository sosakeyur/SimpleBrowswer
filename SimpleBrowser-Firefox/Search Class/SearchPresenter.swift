//
//  SearchPresenter.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/16/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

import UIKit

struct SearchPresenter: SearchPresentable {
    private weak var viewController: SearchDisplayable?
    init(viewController: SearchDisplayable?) {
        self.viewController = viewController
    }
}

extension SearchPresenter {
    func presentFetched(for response: SearchViewModel.Response) {
        viewController?.displayFetched(with: response)
    }

    func presentFetched(error: Error?) {
        viewController?.displayFetched(with: "Error in request.")
    }
}

/// ForAdjusting Height of tableview when keyboard show and hide
extension UIViewController {
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height, right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }

    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
}

extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        contentInset = edgeInsets
        scrollIndicatorInsets = edgeInsets
    }
}

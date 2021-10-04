//
//  AddCardViewController.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 03/10/21.
//

import UIKit

final class AddCardViewController: UIViewController {
    // MARK: - Private attributes

    private lazy var searchBar: SearchBarView = {
        SearchBarView(placeholder: Localizable.AddCardView.SearchBar.placeholder)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSearchBar()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupSearchBar() {
        view.addSubview(searchBar)

        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
}

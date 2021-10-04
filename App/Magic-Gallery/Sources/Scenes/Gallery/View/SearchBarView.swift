//
//  SearchBarView.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 03/10/21.
//

import UIKit

final class SearchBarView: UISearchBar {
    // MARK: - Initialization

    init(placeholder: String?, delegate: UISearchBarDelegate) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        self.delegate = delegate

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        searchBarStyle = .minimal
    }
}

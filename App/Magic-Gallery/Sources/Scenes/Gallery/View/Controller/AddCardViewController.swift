//
//  AddCardViewController.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 03/10/21.
//

import MTGSDKSwift
import UIKit

final class AddCardViewController: UIViewController {
    // MARK: - Private attributes

    private lazy var searchBar: SearchBarView = {
        SearchBarView(placeholder: Localizable.AddCardView.SearchBar.placeholder, delegate: self)
    }()

    private var fetchService: MagicFetchService = {
        let service = MagicFetchService(gameFormat: .standard)
        service.setupCurrentPageNumber(1)
        service.setupPageSize(15)

        return service
    }()

    private var searchResults: [Card] = []

    private let resultsVC = MagicCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSearchBar()
        setupResultsVC()
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

    private func setupResultsVC() {
        addChild(resultsVC)

        view.addSubview(resultsVC.view)

        resultsVC.view.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension AddCardViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            fetchService.setupSearch(cardName: searchText)

            fetchService.fetchCurrentPage { [weak self] cards in
                if let cards = cards {
                    self?.searchResults = cards
                    self?.resultsVC.cards = cards
                    DispatchQueue.main.async {
                        self?.resultsVC.collectionView.reloadData()
                    }
                }
            }
        }
        searchBar.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

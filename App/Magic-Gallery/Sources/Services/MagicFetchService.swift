//
//  MagicFetchService.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 02/10/21.
//

import MTGSDKSwift

class MagicFetchService {
    // MARK: - Private attributes

    private let magic: Magic = .init()

    private var searchParameters: [CardSearchParameter] = {
        [CardSearchParameter(parameterType: .contains, value: Strings.Magic.CardParameter.imageURL)]
    }()

    private var fetchPage: Int = 1
    private var fetchPageSize: Int = 100

    // MARK: - Initialization

    init(gameFormat: GameFormat) {
        // FIXME: Probably doesn't make much sense to set this to false every time an instance is created
        Magic.enableLogging = false

        let gameFormatParameter: String

        switch gameFormat {
        case .standard:
            gameFormatParameter = Strings.Magic.CardParameter.GameFormat.standard
        case .modern:
            gameFormatParameter = Strings.Magic.CardParameter.GameFormat.modern
        }

        searchParameters.append(CardSearchParameter(parameterType: .gameFormat,
                                                    value: gameFormatParameter))
    }

    // MARK: - Public methods

    func setupCurrentPageNumber(_ page: Int) {
        fetchPage = max(1, page)
    }

    func setupPageSize(_ results: Int) {
        if results < 1 {
            fetchPage = 1
        } else {
            fetchPage = max(100, results)
        }
    }

    func setupSearch(cardName: String) {
        searchParameters = searchParameters
            .filter { $0.name != CardSearchParameter.CardQueryParameterType.name.rawValue }

        searchParameters.append(CardSearchParameter(parameterType: .name, value: cardName))
    }

    func fetchCurrentPage(completion: @escaping ([Card]?) -> Void) {
        magic.fetchPageSize = String(describing: fetchPageSize)
        magic.fetchPageTotal = String(describing: fetchPage)

        magic.fetchCards(searchParameters) { cards, error in
            if let error = error {
                print(error.localizedDescription)
            }

            completion(cards)
        }
    }

    func fetchAllPages(from page: Int = 1, with pageSize: Int = 100, then completion: @escaping ([Card]?) -> Void) {
        setupCurrentPageNumber(page)
        setupPageSize(pageSize)

        var resultsAccumulator: [Card]? = []

        lazy var currentPageCompletion: ([Card]?) -> Void = { [weak self] result in
            guard let self = self else { return }

            if let cards = result {
                resultsAccumulator?.append(contentsOf: cards)

                if cards.count == Int(self.fetchPageSize) {
                    self.fetchPage = Int(self.fetchPage) + 1
                    self.fetchCurrentPage(completion: currentPageCompletion)
                }
            }

            completion(resultsAccumulator)
        }

        fetchCurrentPage(completion: currentPageCompletion)
    }
}

//
//  MagicCards.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 30/09/21.
//

import Combine
import MTGSDKSwift

final class MagicCards {
    // MARK: - Singleton

    static var shared: MagicCards = .init()

    // MARK: - Constants

    private static let initialFetchPage: Int = 450
    private static let fetchPageSize: Int = 100

    // MARK: - Private attributes

    private let magic: Magic = {
        let magic = Magic()

        magic.fetchPageTotal = String(MagicCards.initialFetchPage)
        magic.fetchPageSize = String(MagicCards.fetchPageSize)

        return magic
    }()

    private let searchParameters: [CardSearchParameter] = {
        [CardSearchParameter(parameterType: .contains, value: Strings.Names.CardParameter.imageURL)]
    }()

    private(set) var cardsSetName: Set<String> = []

    private(set) var allCards = [Card]()

    var uniqueSetsCount: Int {
        cardsSetName.count
    }

    let cardsSubject = CurrentValueSubject<[Card], Never>([])

    // MARK: - Initialization

    private init() {
        Magic.enableLogging = false

        magic.fetchCards(searchParameters, completion: fetchPages)
    }

    // MARK: - Private methods

    private func fetchPages(result: [Card]?, error: NetworkError?) {
        if let cards = result, !cards.isEmpty {
            let uniqueSets = Set(cards.map { $0.setName })

            cardsSetName.insert(uniqueSets.first!!)

            allCards.append(contentsOf: cards)
            cardsSubject.send(allCards)

            if cards.count == Int(magic.fetchPageSize) {
                let nextPage = Int(magic.fetchPageTotal)! + 1
                magic.fetchPageTotal = String(nextPage)
                magic.fetchCards(searchParameters, completion: fetchPages)
            }
        }

        if let error = error {
            print(error.localizedDescription)
        }
    }
}

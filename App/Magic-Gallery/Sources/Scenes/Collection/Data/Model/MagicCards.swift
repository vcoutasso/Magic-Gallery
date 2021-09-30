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

    // MARK: - Private attributes

    private let magic: Magic = {
        let magic = Magic()

        magic.fetchPageTotal = "450"
        magic.fetchPageSize = "100"

        return magic
    }()

    private let searchParameters: [CardSearchParameter] = {
        [CardSearchParameter(parameterType: .contains, value: "imageUrl")]
    }()

    private(set) var allCards = [Card]()

    let cardsSubject = CurrentValueSubject<[Card], Never>([])

    // MARK: - Initialization

    private init() {
        Magic.enableLogging = false

        magic.fetchCards(searchParameters, completion: fetchPages)
    }

    // MARK: - Private methods

    private func fetchPages(result: [Card]?, error: NetworkError?) {
        if let cards = result, !cards.isEmpty {
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

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

    private let fetchService: MagicFetchService = .init(gameFormat: .standard)

    private(set) var cardsSetName: Set<String> = []

    private(set) var allCards = [Card]()

    var uniqueSetsCount: Int {
        cardsSetName.count
    }

    let cardsSubject = CurrentValueSubject<[Card], Never>([])

    // MARK: - Initialization

    private init() {
        fetchService.fetchAllPages { [weak self] results in
            guard let self = self else { return }

            if let cards = results, !cards.isEmpty {
                let uniqueSets = Set(cards.map { $0.setName })

                self.cardsSetName.insert(uniqueSets.first!!)
                self.allCards.append(contentsOf: cards)
                self.cardsSubject.send(self.allCards)
            }
        }
    }
}

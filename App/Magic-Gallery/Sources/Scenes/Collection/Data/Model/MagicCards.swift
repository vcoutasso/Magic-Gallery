//
//  MagicCards.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 30/09/21.
//

import Combine
import MTGSDKSwift

class MagicCards {
    // MARK: - Singleton

    static var shared: MagicCards = .init()

    // MARK: - Private attributes

    private let magic: Magic = {
        let magic = Magic()
        magic.fetchPageTotal = "1"
        magic.fetchPageSize = "100"

        return magic
    }()

    private(set) var allCards = [Card]()

    let cardsSubject = CurrentValueSubject<[Card], Never>([])

    // MARK: - Initialization

    private init() {
        magic.fetchCards([]) { [weak self] cards, error in
            guard let self = self else { return }

            if let cards = cards {
                self.allCards.append(contentsOf: cards)
                self.cardsSubject.send(self.allCards)
            }

            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

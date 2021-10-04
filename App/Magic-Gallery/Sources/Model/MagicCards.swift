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

    private(set) var setNames: Set<String> = []

    private(set) var allCards = [Card]()

    var uniqueSetsCount: Int {
        setNames.count
    }

    let cardsSubject = CurrentValueSubject<[Card], Never>([])

    // MARK: - Initialization

    private init() {}

    // MARK: - Public methods

    func addCard(_ card: Card) {
        allCards.append(card)
        cardsSubject.send(allCards)
    }
}

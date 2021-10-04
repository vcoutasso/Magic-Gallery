//
//  FetchResultsCollectionViewController.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 04/10/21.
//

import MTGSDKSwift
import UIKit

class FetchResultsCollectionViewController: MagicCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        cardsSubscription = nil
    }

    // MARK: - Public methods

    func updateCards(_ cards: [Card]) {
        self.cards = cards

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Collection methods

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MagicCards.shared.addCard(cards[indexOfCardAt(indexPath)])
    }
}

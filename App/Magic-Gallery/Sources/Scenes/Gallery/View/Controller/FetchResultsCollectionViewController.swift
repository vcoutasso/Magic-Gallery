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
        var index = 0
        for i in 0..<indexPath.section {
            index += collectionView.numberOfItems(inSection: i)
        }
        index += indexPath.row

        MagicCards.shared.addCard(cards[index])
    }
}

//
//  MagicCollectionViewController.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 28/09/21.
//

import Combine
import MTGSDKSwift
import UIKit

final class MagicCollectionViewController: UICollectionViewController {
    // MARK: Private attributes

    private var cards = [Card]()
    private var cardCollections: Int = 1
    private var cardsSubscription: AnyCancellable?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        cardsSubscription = MagicCards.shared.cardsSubject
            .receive(on: RunLoop.main, options: nil)
            .sink { [weak self] cards in
                guard let self = self else { return }

                self.cards = cards
                self.collectionView.reloadData()
            }

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(CollectionCardViewCell.self)
        collectionView.register(CollectionSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }

    deinit {
        cardsSubscription?.cancel()
    }

    // MARK: Collection methods

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        cardCollections
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: CollectionCardViewCell.defaultReuseIdentifier,
                                 for: indexPath) as? CollectionCardViewCell else {
            return UICollectionViewCell()
        }

        cell.setup(with: cards[(indexPath.section * Int(LayoutMetrics.itemsPerRow)) + indexPath.row])

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: CollectionSectionHeaderView
                                                      .defaultReuseIdentifier,
                                                  for: indexPath) as? CollectionSectionHeaderView else {
                return UICollectionReusableView()
            }

            sectionHeader.setText("Titulo")

            return sectionHeader

        } else {
            return UICollectionReusableView()
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        if let card = cell as? CollectionCardViewCell {
            card.cancelDownloadTask()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: CollectionSectionHeaderView.LayoutMetrics.titleFontSize)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width -
            2 * LayoutMetrics.sectionHorizontalInset -
            (LayoutMetrics.itemsPerRow - 1) * LayoutMetrics.interitemSpacing) / LayoutMetrics.itemsPerRow

        return CGSize(width: width, height: width * LayoutMetrics.cardAspectRatio)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutMetrics.interitemSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LayoutMetrics.interitemSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: LayoutMetrics.sectionVerticalInset,
                     left: LayoutMetrics.sectionHorizontalInset,
                     bottom: LayoutMetrics.sectionVerticalInset,
                     right: LayoutMetrics.sectionHorizontalInset)
    }

    // MARK: Layout Metrics

    private enum LayoutMetrics {
        static let itemsPerRow: CGFloat = 3
        static let interitemSpacing: CGFloat = 10
        static let sectionVerticalInset: CGFloat = 15
        static let sectionHorizontalInset: CGFloat = CollectionSectionHeaderView.LayoutMetrics.titleLeadingOffset
        static let cardAspectRatio: CGFloat = 4 / 3
    }
}

extension MagicCollectionViewController: UICollectionViewDelegateFlowLayout {}

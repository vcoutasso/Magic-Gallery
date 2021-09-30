//
//  MagicCollectionViewController.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 28/09/21.
//

import UIKit

class MagicCollectionViewController: UICollectionViewController {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(CollectionCardViewCell.self)
        collectionView.register(CollectionSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }

    // MARK: Collection methods

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: CollectionCardViewCell.defaultReuseIdentifier,
                                 for: indexPath) as? CollectionCardViewCell else {
            return UICollectionViewCell()
        }

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

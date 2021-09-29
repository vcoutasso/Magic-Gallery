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

        collectionView.register(CollectionCardViewCell.self)
        collectionView.register(CollectionSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }

    // MARK: Collection methods

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: CollectionCardViewCell.defaultReuseIdentifier,
                                 for: indexPath)

        cell.backgroundColor = .purple

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
        CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension MagicCollectionViewController: UICollectionViewDelegateFlowLayout {}

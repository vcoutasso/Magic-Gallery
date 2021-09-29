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

        collectionView.register(UICollectionViewCell.self)
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
        let cell = collectionView.dequeueReusableCell(for: indexPath)

        cell.backgroundColor = UIColor.purple

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: CollectionSectionHeaderView
                                                      .defaultReuseIdentifier,
                                                  for: indexPath)
//            sectionHeader?.setText("Titulo")
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension MagicCollectionViewController: UICollectionViewDelegateFlowLayout {}

//
//  CollectionCardViewCell.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 29/09/21.
//

import MTGSDKSwift
import UIKit

class CollectionCardViewCell: UICollectionViewCell {
    // MARK: - Private attributes

    private var card: Card?

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray

        return imageView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Public methdos

    func setup(with card: Card) {
        self.card = card

        if let urlString = card.imageUrl {
            if let url = URL(string: urlString) {
                imageView.load(url: url)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionCardViewCell: ReusableView {}

//
//  CollectionCardViewCell.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 29/09/21.
//

import Kingfisher
import MTGSDKSwift
import UIKit

final class CollectionCardViewCell: UICollectionViewCell {
    // MARK: - Private attributes

    private var card: Card?

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity

        return imageView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImageView()
    }

    // MARK: - Private methods

    private func setupImageView() {
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Public methdos

    func setup(with card: Card) {
        self.card = card

        if let urlString = card.imageUrl {
            imageView.kf.setImage(with: URL(string: urlString), placeholder: UIImage(named: ""))
        }
    }

    func cancelDownloadTask() {
        imageView.kf.cancelDownloadTask()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionCardViewCell: ReusableView {}

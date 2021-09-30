//
//  CollectionCardViewCell.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 29/09/21.
//

import UIKit

class CollectionCardViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.backgroundColor = .lightGray

        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionCardViewCell: ReusableView {}

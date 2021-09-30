//
//  CollectionCardViewCell.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 29/09/21.
//

import MTGSDKSwift
import UIKit

class CollectionCardViewCell: UICollectionViewCell {
    let magic = Magic()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let color = CardSearchParameter(parameterType: .colors, value: "black")
        let cmc = CardSearchParameter(parameterType: .cmc, value: "2")
        let setCode = CardSearchParameter(parameterType: .set, value: "AER")

        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray

        magic.fetchCards([color, cmc, setCode]) { cards, error in

            if let error = error {
                print(error)
            }

            imageView.load(url: URL(string: cards!.first!.imageUrl!)!)
        }

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

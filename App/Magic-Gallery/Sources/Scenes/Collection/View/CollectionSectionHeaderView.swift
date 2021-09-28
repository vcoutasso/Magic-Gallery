//
//  CollectionSectionHeaderView.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 28/09/21.
//

import SnapKit
import UIKit

class CollectionSectionHeaderView: UICollectionReusableView {
    private lazy var label: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.text = "Default Header Title"
        label.font = .systemFont(ofSize: 24, weight: .bold)

        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)

//        label.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.leading.equalToSuperview()
//                .offset(20)
//        }
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func setText(_ text: String) {
        label.text = text
    }
}

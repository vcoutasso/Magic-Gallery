//
//  CollectionSectionHeaderView.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 28/09/21.
//

import SnapKit
import UIKit

final class CollectionSectionHeaderView: UICollectionReusableView {
    private lazy var label: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.text = "Default Header Title"
        label.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .bold)

        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
                .offset(LayoutMetrics.titleLeadingOffset)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func setText(_ text: String) {
        label.text = text
    }

    // MARK: - Layout Metrics

    enum LayoutMetrics {
        static let titleFontSize: CGFloat = 28
        static let titleLeadingOffset: CGFloat = 16
    }
}

extension CollectionSectionHeaderView: ReusableView {}

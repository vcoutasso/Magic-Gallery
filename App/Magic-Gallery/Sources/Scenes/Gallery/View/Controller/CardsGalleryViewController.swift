//
//  CardsGalleryViewController.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 03/10/21.
//

import Foundation
import UIKit

final class CardsGalleryViewController: UIViewController {
    // MARK: - Private attributes

    private let collectionVC = MagicCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

    private lazy var headerStackView: UIStackView = {
        let titleLabel = UILabel()

        titleLabel.textColor = .black
        titleLabel.text = "My Magic Collection"
        titleLabel.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .bold)

        let addButton = UIButton()
        addButton.setImage(UIImage(systemName: Strings.Icons.addSymbol), for: .normal)
        addButton.addTarget(self, action: #selector(handleAddButtonTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, addButton])
        stack.axis = .horizontal

        return stack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHeaderView()
        setupCollectionVC()
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupHeaderView() {
        view.addSubview(headerStackView)

        headerStackView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.leading.trailing.equalToSuperview()
                .inset(LayoutMetrics.horizontalInset)
        }
    }

    private func setupCollectionVC() {
        addChild(collectionVC)

        view.addSubview(collectionVC.view)

        collectionVC.view.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    @objc private func handleAddButtonTapped() {
        modalPresentationStyle = .fullScreen
        present(AddCardViewController(), animated: true)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let titleFontSize: CGFloat = 28
        static let horizontalInset: CGFloat = 16
    }
}

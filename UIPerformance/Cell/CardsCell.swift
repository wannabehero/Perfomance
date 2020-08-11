//
//  CollectionCell.swift
//  UIPerformance
//
//  Created by Aleksandr Lavrinenko on 11.08.2020.
//  Copyright © 2020 Sergey Pronin. All rights reserved.
//

import UIKit
import LoremIpsum

class CardsCell: TextCell {
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

	override init(frame: CGRect) {
		super.init(frame: frame)

		textStackView.translatesAutoresizingMaskIntoConstraints = false
		textStackView.addArrangedSubview(collectionView)

		collectionView.register(CardCell.self, forCellWithReuseIdentifier: "Card")
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .white
		collectionView.layer.cornerRadius = 6

		NSLayoutConstraint.activate([
			collectionView.heightAnchor.constraint(equalToConstant: 160)
			])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

fileprivate class CardCell: UICollectionViewCell, ConfigrableCell {
	let imageView: UIImageView = {
		let photoImageView = UIImageView()
		photoImageView.contentMode = .scaleAspectFit
		photoImageView.layer.cornerRadius = 6
		return photoImageView
	}()
	let titleLabel = UILabel()
	let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.distribution = .equalSpacing
		stackView.isOpaque = true
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		stackView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stackView)

		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(titleLabel)


		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),

			imageView.heightAnchor.constraint(equalToConstant: 160),

			contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure() {
		titleLabel.text = LoremIpsum.name
		LoremIpsum.asyncPlaceholderImage(with: CGSize(width: 200, height: 400)) { (image) in
			self.imageView.image = image
		}
	}
}

extension CardsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! ConfigrableCell
		cell.configure()
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: 160, height: 160)
	}
}
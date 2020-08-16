//
//  LottieCell.swift
//  UIPerformance
//
//  Created by Aleksandr Lavrinenko on 12.08.2020.
//  Copyright © 2020 Sergey Pronin. All rights reserved.
//

import UIKit
import Lottie
import LoremIpsum

final class LottieCell: TextCell {

	let animationView: AnimationView = {
		let animation = Animation.named("Animation")
		let animationView = AnimationView()
		animationView.animation = animation
		animationView.contentMode = .scaleAspectFit
		return animationView
	}()


	override init(frame: CGRect) {
		super.init(frame: frame)

		animationView.translatesAutoresizingMaskIntoConstraints = false
		textStackView.addArrangedSubview(animationView)

		NSLayoutConstraint.activate([
			animationView.heightAnchor.constraint(equalToConstant: 160),
			animationView.widthAnchor.constraint(equalToConstant: 160)
		])
	}

	func configure(model: LottieModel) {
		titleLabel.attributedText = model.title
		descriptionLabel.text = ""
		animationView.animation = model.animation
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
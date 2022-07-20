//
//  PhotoCollectionViewCell.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/17/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - @IBOutlets

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Properties

    static let identifier = "PhotoCollectionViewCell"

    // MARK: - Methods

    func setupView(imageURL: String, title: String) {
        if let url = URL(string: imageURL) {
            photoImage.kf.setImage(with: url)
            photoImage.layer.cornerRadius = 10
        }
        titleLabel.text = title
    }
}

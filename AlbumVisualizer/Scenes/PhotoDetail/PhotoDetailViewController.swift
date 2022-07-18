//
//  PhotoDetailViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    // MARK: - @IBOutlets

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoTitle: UILabel!

    // MARK: - Properties

    var photo: Photo!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
    }

    // MARK: - Methods

    private func prepareUI() {
        scrollView.delegate = self
        photoTitle.text = photo.title
        photoImage.layer.cornerRadius = 15
        if let url = URL(string: photo.url) {
            photoImage.kf.setImage(with: url)
        }
    }

    private func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - photoImage.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset

        let xOffset = max(0, (size.width - photoImage.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset

        view.layoutIfNeeded()
    }
}

// MARK: - UIScrollViewDelegate

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in _: UIScrollView) -> UIView? {
        photoImage
    }

    func scrollViewDidZoom(_: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
}

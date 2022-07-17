//
//  PhotoViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import UIKit

class PhotoViewController: UIViewController {
    // MARK: - @IBOutlets

    // MARK: - Properties

    var album: Album?

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photos"
        print("Current Album: ", album)
        // Do any additional setup after loading the view.
    }
}

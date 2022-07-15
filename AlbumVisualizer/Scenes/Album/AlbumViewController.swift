//
//  AlbumViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import UIKit

class AlbumViewController: UIViewController {
    // MARK: - Properties

    private let userDefaults = UserDefaults.standard

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayOnBoarding()
    }

    // MARK: - Methods

    private func displayOnBoarding() {
        DispatchQueue.main.async {
            if !self.userDefaults.onBoardingHasBeenShown {
                self.present(StoryboardScene.OnBoarding.initialScene.instantiate(), animated: true)
            }
        }
    }

    private func prepareUI() {
    }
}

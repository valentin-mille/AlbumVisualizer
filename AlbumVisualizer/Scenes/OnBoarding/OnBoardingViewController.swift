//
//  OnBoardingViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import Lottie
import RxCocoa
import UIKit

class OnBoardingViewController: UIViewController {
    // MARK: - @IBOutlets

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var startButton: ButtonAnimated!

    // MARK: - Properties

    private var viewModel: OnBoardingViewModel?
    private let animationName = "Image"

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnBoardingViewModel()
        bindViewModel()
        prepareUI()
    }

    // MARK: - Methods

    private func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }

        let input = OnBoardingViewModel.Input(buttonPressed: startButton.rx.tap)
        viewModel.transform(input: input)
    }

    private func prepareUI() {
        animationView.animation = Animation.named(animationName)
        animationView.loopMode = .loop
        animationView.play()

        startButton.setTitle(Strings.OnBoarding.buttonTitle.capitalized, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        startButton.layer.cornerRadius = 15

        titleLabel.text = Strings.OnBoarding.title.capitalized
        subtitleLabel.text = Strings.OnBoarding.subtitle
    }

    // MARK: - @IBActions

    @IBAction
    func startAction(_: ButtonAnimated) {
        dismiss(animated: true)
    }
}

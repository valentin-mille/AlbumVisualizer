//
//  OnBoardingViewModel.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import RxCocoa
import RxSwift

class OnBoardingViewModel {
    // MARK: - Properties

    private let bag = DisposeBag()
    private let userDefaults = UserDefaults.standard

    struct Input {
        let didPressButton: ControlEvent<Void>
    }

    func transform(input: Input) -> Void {
        let output = input.didPressButton.subscribe(onNext: {
            self.userDefaults.onBoardingHasBeenShown = true
        })
        output.disposed(by: bag)
    }
}

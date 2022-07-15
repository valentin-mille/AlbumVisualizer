//
//  AnimateHighlight.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import UIKit

struct HighlightAnimatableSettings {
    var duration: TimeInterval = 0.5
    var delay: TimeInterval = 0.0
    var springDamping: CGFloat = 1.0
    var springVelocity: CGFloat = 0.0
    var options: UIView.AnimationOptions = [.allowUserInteraction]
    var transform: CGAffineTransform = .init(scaleX: 0.90, y: 0.90)
}

struct AssociatedKeys {
    static var highlightAnimation = "VIV_highlightAnimation"
}

protocol AnimateHighlight: AnyObject {
    var settings: HighlightAnimatableSettings { get }
    func lockAnimation()
    func unlockAnimation()
    func highlight(_ touched: Bool)
    func highlight(_ touched: Bool, completion: ((Bool) -> Void)?)
}

extension AnimateHighlight where Self: UIView {

    private var animationAvailable: Bool {
        get { return (objc_getAssociatedObject(self, &AssociatedKeys.highlightAnimation) as? Bool) ?? true }
        set { objc_setAssociatedObject(self, &AssociatedKeys.highlightAnimation, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }

    var settings: HighlightAnimatableSettings { return HighlightAnimatableSettings() }

    func lockAnimation() {
        animationAvailable = false
        layer.removeAllAnimations()
    }

    func unlockAnimation() {
        animationAvailable = true
    }

    func highlight(_ touched: Bool) {
        highlight(touched, completion: nil)
    }

    func highlight(_ touched: Bool, completion: ((Bool) -> Void)?) {
        guard animationAvailable else { return }

        let color = touched ? self.backgroundColor?.withAlphaComponent(0.9) : self.backgroundColor?.withAlphaComponent(1)
        if self.layer.borderWidth > 0 {
            let borderColor = self.layer.borderColor
            self.layer.borderColor = borderColor?.copy(alpha: touched ? 0.9 : 1)
        } else {
            self.backgroundColor = color
        }
        UIView.animate(withDuration: settings.duration,
                       delay: settings.delay,
                       usingSpringWithDamping: settings.springDamping,
                       initialSpringVelocity: settings.springVelocity,
                       options: settings.options,
                       animations: {
                        self.transform = touched ? self.settings.transform : .identity
        }, completion: completion)
    }

}

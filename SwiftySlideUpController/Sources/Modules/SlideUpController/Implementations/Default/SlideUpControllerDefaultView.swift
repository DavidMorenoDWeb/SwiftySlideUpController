//
//  SlideUpControllerDefaultView.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

open class SlideUpControllerDefaultView: UIViewController {

    public var presenter: SlideUpControllerPresenter?
    
    // MARK: Outlets
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var closeTitleLabel: UILabel!
    @IBOutlet weak var openTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Constants
    
    private let popupOffset: CGFloat = 440
    
    // MARK: Properties
    
    private lazy var panRecognizer: InstantPanGestureRecognizer = {
        let recognizer = InstantPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()
    
    /// The current state of the animation. This variable is changed only when an animation completes.
    private var currentState: State = .closed
    
    /// All of the currently running animators.
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    /// The progress of each animator. This array is parallel to the `runningAnimators` array.
    private var animationProgress = [CGFloat]()
    
    // MARK: Initializers
    
    public init(){
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nil, bundle: bundle)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Life-Cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        configOverlayView()
        configPopupView()
        configOpenTitleLabel()
        popupView.addGestureRecognizer(panRecognizer)
    }
    
    // MARK: Methods
    
    private func configPopupView() {
        if #available(iOS 11.0, *) {
            popupView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.1
        popupView.layer.shadowRadius = 10
    }
    
    private func configOverlayView() {
        overlayView.alpha = 0.0
    }
    
    private func configOpenTitleLabel() {
        openTitleLabel.alpha = 0
        openTitleLabel.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(translationX: 0, y: -15))
    }
    
    /// Animates the transition, if the animation is not already running.
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        
        // ensure that the animators array is empty (which implies new animations need to be created)
        guard runningAnimators.isEmpty else { return }
        
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.popupView.layer.cornerRadius = 20
                self.overlayView.alpha = 0.5
                                self.closeTitleLabel.transform = CGAffineTransform(scaleX: 1.6, y: 1.6).concatenating(CGAffineTransform(translationX: 0, y: 15))
                            self.openTitleLabel.transform = .identity
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
                self.popupView.layer.cornerRadius = 0
                self.overlayView.alpha = 0
                                self.closeTitleLabel.transform = .identity
                                self.openTitleLabel.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(translationX: 0, y: -15))
            }
            self.view.layoutIfNeeded()
        })
        
        // the transition completion block
        transitionAnimator.addCompletion { position in
            
            // update the state
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            @unknown default:
                ()
            }
            
            // manually reset the constraint positions
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
            }
            
            // remove all running animators
            self.runningAnimators.removeAll()
            
        }
        
        // an animator for the title that is transitioning into view
        let inTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: {
                        switch state {
                        case .open:
                            self.openTitleLabel.alpha = 1
                        case .closed:
                            self.closeTitleLabel.alpha = 1
                        }
        })
        if #available(iOS 11.0, *) {
            inTitleAnimator.scrubsLinearly = false
        } else {
            // Fallback on earlier versions
        }
        
        // an animator for the title that is transitioning out of view
        let outTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut, animations: {
                        switch state {
                        case .open:
                            self.closeTitleLabel.alpha = 0
                        case .closed:
                            self.openTitleLabel.alpha = 0
                        }
        })
        if #available(iOS 11.0, *) {
            outTitleAnimator.scrubsLinearly = false
        } else {
            // Fallback on earlier versions
        }
        
        // start all animators
        transitionAnimator.startAnimation()
        inTitleAnimator.startAnimation()
        outTitleAnimator.startAnimation()
        
        // keep track of all running animators
        runningAnimators.append(transitionAnimator)
        runningAnimators.append(inTitleAnimator)
        runningAnimators.append(outTitleAnimator)
        
    }
    
    // MARK: Gesture handlers
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            
            // start the animations
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
            
            // pause all animations, since the next event may be a pan changed
            runningAnimators.forEach { $0.pauseAnimation() }
            
            // keep track of each animator's progress
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            
            // variable setup
            let translation = recognizer.translation(in: popupView)
            var fraction = -translation.y / popupOffset
            
            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }
            
            // apply the new fraction
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            
            // variable setup
            let yVelocity = recognizer.velocity(in: popupView).y
            let shouldClose = yVelocity > 0
            
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            // reverse the animations based on their current state and pan motion
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }
            
            // continue all animations
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            ()
        }
    }
}

extension SlideUpControllerDefaultView: SlideUpControllerView {
    
    public func present(in vc: UIViewController) {
        self.presenter?.present(in: vc)
    }
}

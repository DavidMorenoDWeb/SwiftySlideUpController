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
    
    // MARK: Outlets
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var closeTitleLabel: UILabel!
    @IBOutlet weak var openTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var headerContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var popupHeightConstraint: NSLayoutConstraint!
    // MARK: Properties
    
    /// The Pan Gesture Recognized for the slide behavior
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        recognizer.delegate = self
        return recognizer
    }()
    
    /// The Tap Gesture Recognized for the header tap behavior
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewTapped(recognizer:)))
        return recognizer
    }()
    
    /// The handler for the tableview items. It implements UITableViewDataSource and UITableViewDelegate
    public var itemHandler: SlideUpDefaultItemHandler?
    
    /// The height of the popup. Default is 500.0
    public var popupHeight: CGFloat = 500.0 {
        didSet {
            popupHeightConstraint.constant = popupHeight
        }
    }
    
    /// The current state of the animation. This variable is changed only when an animation completes.
    private var currentState: State = .closed {
        didSet {
            tableView.isScrollEnabled = true
        }
    }
    
    /// All of the currently running animators.
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    /// The progress of each animator. This array is parallel to the `runningAnimators` array.
    private var animationProgress = [CGFloat]()
    
    /// The height of the header view container
    private var headerViewHeight: CGFloat {
        return !UIDevice.hasNotch ? 60.0 : 80.0
    }
    
    /// The offset that will be applied to the popup bottom constraint
    private var popupOffset: CGFloat {
        return popupHeight - headerViewHeight
    }
    
    // MARK: SlideUpControllerView properties
    
    /// The presenter for the view
    public var presenter: SlideUpControllerPresenter?
    
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
        headerContainerView.addGestureRecognizer(tapRecognizer)
        itemHandler = SlideUpDefaultItemHandler(slideUpController: self)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setHeaderAndOffsetConstraints()
    }
    
    // MARK: Methods
    
    /// Sets the masked corners to the popup and configures its shadow
    private func configPopupView() {
        if #available(iOS 11.0, *) {
            popupView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
    
    /// Sets the header container height and the bottom constraint of the popup
    private func setHeaderAndOffsetConstraints() {
        headerContainerViewHeightConstraint.constant = headerViewHeight
        bottomConstraint.constant = popupOffset
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
            
            if !runningAnimators.isEmpty {
                self.tableView.isScrollEnabled = runningAnimators[0].fractionComplete == 0.0
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
    
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer) {
        animateTransitionIfNeeded(to: currentState.opposite, duration: 0.8)
    }
}

extension SlideUpControllerDefaultView: SlideUpControllerView {
    
    public func addItem(_ item: SlideUpControllerItem<Any>) {
        presenter?.addItem(item)
        tableView.reloadData()
    }
    
    public func present(in vc: UIViewController) {
        presenter?.present(in: vc)
    }
    
    public func set(mainColor color: UIColor) {
        presenter?.set(mainColor: color)
    }
    
    public func set(headerTitle title: String) {
        presenter?.set(headerTitle: title)
    }
    
    public func set(controllerHeight height: CGFloat) {
        popupHeight = height
        setHeaderAndOffsetConstraints()
    }
    
    public func mainColorSetted() {
        if let color = presenter?.mainColor {
            closeTitleLabel.textColor = color
        }
    }
    
    public func headerTitleSetted() {
        if let title = presenter?.headerTitle {
            openTitleLabel.text = title
            closeTitleLabel.text = title
        }
    }
}

extension SlideUpControllerDefaultView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let touchLocation = gestureRecognizer.location(in: popupView)
        let shouldBegin = (currentState == .open && tableView.contentOffset.y == 0) || currentState == .closed || touchLocation.y < headerContainerView.frame.height
        
        return shouldBegin
    }
}

//
//  ViewController.swift
//  TermButton
//
//  Created by Venkatnarayansetty, Badarinath on 8/23/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let models = ["$", "$$", "$$$" , "$$$$"]
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private lazy var mainStackView:UIStackView =  {
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fillProportionally
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    private lazy var buttonStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2.0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    public lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "dots_unfilled"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setTitle("Price  ", for: UIControl.State.normal)
        button.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(expandButton(_:)), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var mainStackWidthConstraint:NSLayoutConstraint!
    
    var widthConstant:CGFloat = 120 {
        didSet {
             self.mainStackWidthConstraint.constant = widthConstant
             self.pinBackground(self.backgroundView, to: self.mainStackView)
        }
    }
    
    var buttonsAreHidden = true {
        didSet {
            performAnimation()
        }
    }
    
    var updateButtonImage = false {
        didSet {
            self.button.setImage(UIImage(named: updateButtonImage ? "dots_filled" : "dots_unfilled"), for: UIControl.State.normal)
        }
    }

    override func viewDidLoad() {
       super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.white
        
        //main stack will have price button & stack view
        configureMainStackView()
        
        //add buttons to stack view
        configureButtonsStack()
        
        //hide the stack view initially
        buttonStackView.isHidden = true
        
        //set backgroundView to hold stackviews
        pinBackground(backgroundView, to: mainStackView)
    }
    
    @objc func expandButton(_ sender: UIButton) {
        buttonsAreHidden.toggle()
    }
}

// MARK: stack views configuration
extension ViewController {
    
    private func configureMainStackView() {
        self.view.addSubview(mainStackView)
        
        [button, buttonStackView].forEach { (view) in
            self.mainStackView.addArrangedSubview(view)
        }
        
        /// set constraints
        mainStackWidthConstraint = self.mainStackView.widthAnchor.constraint(equalToConstant: widthConstant)
        
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            mainStackWidthConstraint,
            self.mainStackView.heightAnchor.constraint(equalToConstant: 40),
            self.button.topAnchor.constraint(equalTo: self.mainStackView.topAnchor),
        ])
    }
    
    private func configureButtonsStack() {
        models.forEach { value in
            let dollar = UIButton(type: .system)
            dollar.translatesAutoresizingMaskIntoConstraints = false
            dollar.setTitle(value, for: UIControl.State.normal)
            dollar.addLeftBorder()
            dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
            buttonStackView.addArrangedSubview(dollar)
        }
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
}

// MARK : animation
extension ViewController {
    
    fileprivate func performAnimation() {
        let screenSize = UIScreen.main.bounds
        
        let stackedButtons = self.buttonStackView.arrangedSubviews
        
        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            
            //hide or show the stackview.
            self.buttonStackView.isHidden = self.buttonsAreHidden
            
            /// change button image and update the width constraint
            self.updateButtonImage = !self.buttonsAreHidden
            self.widthConstant = self.buttonsAreHidden ?  self.button.frame.width : screenSize.size.width - 20
            
            //handle left borders while animating.
            stackedButtons.forEach({ (button) in
                button.layer.sublayers?.first?.isHidden = self.buttonsAreHidden
            })
            
            //remove all existing constraints
            self.backgroundView.constraints.forEach({ (constraint) in
                constraint.isActive = false
            })
            
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
    }
}

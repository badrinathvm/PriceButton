//
//  ViewController.swift
//  TermButton
//
//  Created by Venkatnarayansetty, Badarinath on 8/23/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var models = ["$", "$$", "$$$" , "$$$$"]
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2.0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var mainStackView:UIStackView =  {
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fillProportionally
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
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
    
    var widthConstant:CGFloat = 120
    
    var buttonsAreHidden = true {
        didSet {
            performAnimation()
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
        stackView.isHidden = true
        
        //set backgroundView to hold stackviews
        pinBackground(backgroundView, to: mainStackView, constant: widthConstant)
    }
    
    @objc func expandButton(_ sender: UIButton) {
        buttonsAreHidden.toggle()
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView , constant: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView, constant: constant)
    }
}

// MARK: stack views configuration
extension ViewController {
    
    private func configureMainStackView() {
        self.view.addSubview(mainStackView)
        
        [button, stackView].forEach { (view) in
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
            stackView.addArrangedSubview(dollar)
        }
    }
}

// MARK : animation
extension ViewController {
    
    fileprivate func performAnimation() {
        let screenSize = UIScreen.main.bounds
        
        let stackedButtons = self.stackView.arrangedSubviews
        
        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.stackView.isHidden = self.buttonsAreHidden
            
            //remove all existing constraints
            self.backgroundView.constraints.forEach({ (constraint) in
                constraint.isActive = false
            })
           
            if self.buttonsAreHidden {
                /// hide the border lines when animating
                stackedButtons.forEach({ (button) in
                    button.layer.sublayers?.first?.isHidden = true
                })
                
                /// change the button image and update the width constraint
                self.button.setImage(UIImage(named: "dots_unfilled"), for: UIControl.State.normal)
                self.mainStackWidthConstraint.constant = self.widthConstant
                self.pinBackground(self.backgroundView, to: self.mainStackView, constant: self.widthConstant )
            }else {
                /// show border lines when animating
                stackedButtons.forEach({ (button) in
                    button.layer.sublayers?.first?.isHidden = false
                })
                
                /// change the button image and update the width constraint
                self.button.setImage(UIImage(named: "dots_filled"), for: UIControl.State.normal)
                self.mainStackWidthConstraint.constant = screenSize.size.width - 20
                self.pinBackground(self.backgroundView, to: self.mainStackView, constant: screenSize.size.width - 20 )
            }
            self.view.layoutIfNeeded()
        }
        
        animation.startAnimation()
    }
}

//
//  ViewController.swift
//  TermButton
//
//  Created by Venkatnarayansetty, Badarinath on 8/23/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.0
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2.0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let dotImage:UIImageView = {
        let dotImage = UIImageView(image: UIImage(named: "threeDots"))
        dotImage.translatesAutoresizingMaskIntoConstraints = false
        return dotImage
    }()
    
    let oneDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$", for: UIControl.State.normal)
        dollar.addLeftBorder()
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    
    let twoDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$$", for: UIControl.State.normal)
        dollar.addLeftBorder()
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    
    let threeDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$$$", for: UIControl.State.normal)
        dollar.addLeftBorder()
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    
    let fourDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$$$$", for: UIControl.State.normal)
        dollar.addLeftBorder()
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    

    var buttonsAreHidden = true {
        didSet {
            let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
               self.stackView.isHidden = self.buttonsAreHidden
                
                //remove all existing constraints
                self.backgroundView.constraints.forEach({ (constraint) in
                    constraint.isActive = false
                })
                
                let screenSize = UIScreen.main.bounds
                var stackedButtons = self.stackView.arrangedSubviews
                
                if self.buttonsAreHidden {
                    stackedButtons.forEach({ (button) in
                        button.layer.sublayers?.first?.isHidden = true
                    })
                    self.pinBackground(self.backgroundView, to: self.mainStackView, constant: 80 )
                }else {
                    stackedButtons.forEach({ (button) in
                        button.layer.sublayers?.first?.isHidden = false
                    })
                    self.pinBackground(self.backgroundView, to: self.mainStackView, constant: screenSize.size.width - 20 )
                }
                self.view.layoutIfNeeded()
            }
            animation.startAnimation()
        }
    }
    
    let mainStackView:UIStackView =  {
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fillProportionally
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    let button:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Price", for: UIControl.State.normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(expandButton(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
   
    override func viewDidLoad() {
       super.viewDidLoad()
       self.view.backgroundColor = UIColor.white
        
       self.view.addSubview(mainStackView)
       
        [button, stackView].forEach { (view) in
            self.mainStackView.addArrangedSubview(view)
        }
    
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.mainStackView.heightAnchor.constraint(equalToConstant: 40),
            
            self.button.topAnchor.constraint(equalTo: self.mainStackView.topAnchor),
            
            self.stackView.topAnchor.constraint(equalTo:self.button.topAnchor)
        ])
        
        [oneDollar, twoDollar, threeDollar, fourDollar].forEach { (button) in
            stackView.addArrangedSubview(button)
        }
        
        stackView.isHidden = true
        pinBackground(backgroundView, to: mainStackView, constant: 80)
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


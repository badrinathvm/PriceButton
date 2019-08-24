//
//  PriceView.swift
//  TermButton
//
//  Created by Venkatnarayansetty, Badarinath on 8/23/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import Foundation
import UIKit

class PriceView:UIView {
    
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
        //dollar.addBorder(side: .left, color: UIColor.lightGray, width: 1)
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    
    let twoDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$$", for: UIControl.State.normal)
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        //dollar.addBorder(side: .left, color: UIColor.lightGray, width: 1)
        //dollar.addBorder(side: .right, color: UIColor.lightGray, width: 1)
        return dollar
    }()
    
    let threeDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$$$", for: UIControl.State.normal)
        //dollar.addBorder(side: .right, color: UIColor.lightGray, width: 1)
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    
    let fourDollar:UIButton = {
        let dollar = UIButton(type: .system)
        dollar.translatesAutoresizingMaskIntoConstraints = false
        dollar.setTitle("$$$$", for: UIControl.State.normal)
        dollar.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        return dollar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButtons() {
        
        self.addSubview(stackView)
        
        [oneDollar, twoDollar, threeDollar, fourDollar].forEach { (button) in
            stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([            
            self.stackView.topAnchor.constraint(equalTo:self.topAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 40),
            
            self.oneDollar.heightAnchor.constraint(equalToConstant: 40),
            self.twoDollar.heightAnchor.constraint(equalToConstant: 40),
            self.threeDollar.heightAnchor.constraint(equalToConstant: 40),
            self.fourDollar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

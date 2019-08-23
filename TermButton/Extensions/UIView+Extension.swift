//
//  UIView+Extension.swift
//  TermButton
//
//  Created by Venkatnarayansetty, Badarinath on 8/23/19.
//  Copyright © 2019 Venkatnarayansetty, Badarinath. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pin(to view: UIView , constant: CGFloat) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            widthAnchor.constraint(equalToConstant: constant),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


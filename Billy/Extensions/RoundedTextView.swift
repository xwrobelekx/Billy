//
//  RoundedTextView.swift
//  Billy
//
//  Created by Kamil Wrobel on 9/4/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit


class RoundedTextField: UITextView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 9
        self.layer.backgroundColor = #colorLiteral(red: 0.7254928946, green: 0.8948153853, blue: 0.9053140283, alpha: 1)
    }
    
}

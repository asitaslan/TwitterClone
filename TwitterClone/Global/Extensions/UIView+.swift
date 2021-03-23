//
//  UIView+.swift
//  TwitterClone
//
//  Created by Asit Aslan on 23.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func cornerRadius(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func makeBorder(width: CGFloat, color: UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
    }
}

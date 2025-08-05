//
//  View.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import UIKit

@IBDesignable
final class View: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

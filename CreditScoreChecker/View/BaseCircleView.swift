//
//  BaseCircleView.swift
//  CreditScoreChecker
//
//  Created by doc on 11/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit
protocol CircleSizeFactor: class{
    var sizeFactor: CGFloat {get}
}

class BaseCircleView: UIView {
    
    weak var delegate: CircleSizeFactor?
    var path: UIBezierPath!
    override func draw(_ rect: CGRect) {
        
        guard let factor = delegate?.sizeFactor else {
            return
        }
        
        self.path = UIBezierPath(ovalIn: CGRect(x: factor, y: factor, width: self.frame.size.width-factor*2.0, height: self.frame.size.height-factor*2.0 ))
        UIColor.black.setStroke()
        path.stroke()
    }
}

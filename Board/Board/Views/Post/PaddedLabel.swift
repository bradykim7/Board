//
//  RoundLabel.swift
//  
//
//  Created by Minseok Brady Kim on 5/17/24.
//

import UIKit

class PaddedLabel: UILabel {
    var edgeInsets = UIEdgeInsets(top: 2.5, left: 8, bottom: 2.5, right: 8)
    
    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: edgeInsets)
        super.drawText(in: paddedRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let width = originalContentSize.width + edgeInsets.left + edgeInsets.right
        let height = originalContentSize.height + edgeInsets.top + edgeInsets.bottom
        return CGSize(width: width, height: height)
    }
}

//
//  PillLabel.swift
//  Easycom Japan PH
//
//  Created by Michael Angelo Zafra on 1/17/23.
//

import Foundation
import UIKit

class PillLabel : UILabel{

    @IBInspectable var color = UIColor.lightGray
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var labelText: String = "None"
    @IBInspectable var fontSize: CGFloat = 10.5

    // This has to be balanced with the number of spaces prefixed to the text
    let borderWidth: CGFloat = 3

    init(text: String, color: UIColor = UIColor.lightGray) {
        super.init(frame: CGRectMake(0, 0, 1, 1))
        labelText = text
        self.color = color
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup(){
        // This has to be balanced with the borderWidth property
        text = "  \(labelText)".uppercased()

        // Credits to https://stackoverflow.com/a/33015915/784318
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        backgroundColor = color
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        font = UIFont.boldSystemFont(ofSize: fontSize)
        textColor = color.contrastColor
        sizeToFit()

        // Credits to https://stackoverflow.com/a/15184257/784318
        frame = CGRectInset(self.frame, -borderWidth, -borderWidth)
    }
}


//
//  EntryCell.swift
//  Easycom Japan PH
//
//  Created by Michael Angelo Zafra on 1/17/23.
//

import Foundation
import UIKit

protocol EntryCellDelegate {
    func shareURL(url:String)
}

class EntryCell: UITableViewCell {
    
    @IBOutlet weak var imageBG: UIView!
    @IBOutlet weak var idLbl: UIButton!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate: EntryCellDelegate?
    var url: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        imageViewLogo.addGestureRecognizer(tap)
        imageViewLogo.isUserInteractionEnabled = true
    }
    
    @objc func tappedMe()
    {
        print("Tapped on Image")
        delegate?.shareURL(url: url)
    }
}

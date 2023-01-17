//
//  DetailViewController.swift
//  Easycom Japan PH
//
//  Created by Michael Angelo Zafra on 1/16/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //SegueData
    var data: Entry = Entry()
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        self.navigationItem.leftItemsSupplementBackButton = true
        
        self.title = "ID: \(data.id ?? 0)"
        lblTitle.text = data.title
        if let url = data.url {
            imageViewLogo.loadFrom(URLAddress: url)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

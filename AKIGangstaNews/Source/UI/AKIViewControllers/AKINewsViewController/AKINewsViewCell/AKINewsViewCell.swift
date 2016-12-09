//
//  AKINewsViewCell.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AKINewsViewCell: UITableViewCell {
    
    @IBOutlet var logoImage: UIImageView?
    @IBOutlet var headerLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func fillModel(content: AKIContent) {
        self.headerLabel?.text = content.header
        self.logoImage?.image = UIImage(named: "logonews")
    }
    
}
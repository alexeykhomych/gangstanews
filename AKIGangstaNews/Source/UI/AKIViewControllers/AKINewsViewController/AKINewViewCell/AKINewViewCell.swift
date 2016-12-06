//
//  AKINewViewCell.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AKINewViewCell: UITableViewCell {
    
    @IBOutlet var logoImage: UIImageView?
    @IBOutlet var headerLabel: UILabel?
    
    public func fillModel(content: AKIContent) {
        self.headerLabel?.text = content.header
        self.logoImage?.image = UIImage(named: "logonews")
    }
    
}

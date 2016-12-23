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
    
    @IBOutlet var newsImageView: AKIImageView?
    @IBOutlet var headerLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillModel(content: AKIContent?) {
        self.headerLabel?.text = content?.header
        self.newsImageView?.imageModel = (content?.imageModel)!
//        self.newsImageView?.imageModel?.image = (content?.imageModel)!.image
    }
    
}

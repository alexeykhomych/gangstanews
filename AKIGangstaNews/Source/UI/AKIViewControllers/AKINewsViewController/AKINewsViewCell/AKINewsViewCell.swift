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
    
    func fillModel(content: AKIContent?) {
        self.headerLabel?.text = content?.header
        self.logoImage?.image = NSURL(string: (content?.imageURL!)!)
            .flatMap { NSData(contentsOf: $0 as URL) }
            .flatMap { UIImage(data: $0 as Data) }
    }
    
}

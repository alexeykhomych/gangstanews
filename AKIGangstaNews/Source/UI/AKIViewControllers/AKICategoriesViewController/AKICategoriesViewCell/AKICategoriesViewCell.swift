//
//  AKICategoriesViewCell.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 12.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKICategoriesViewCell: UITableViewCell {
    
    @IBOutlet var categoryNameLabel: UILabel?
    @IBOutlet var categoryImageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCategory(category: AKICategory) {
        self.categoryNameLabel?.text = category.name
        self.categoryImageView?.image = UIImage(named: "logonews")
    }
    
    func editCategory(category: AKICategory) {
        category.enabled = !category.enabled!
    }    
}

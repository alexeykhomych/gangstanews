//
//  AKICategoriesViewCell.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 12.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKICategoriesViewCell: UITableViewCell {
    
    @IBOutlet var switchCategory: UISwitch?
    @IBOutlet var categoryNameLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCategory(categoryName: String, categoryState: Bool) {
        self.categoryNameLabel?.text = categoryName
        self.switchCategory?.setOn(categoryState, animated: true)
    }
    
}

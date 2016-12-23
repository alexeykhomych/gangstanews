//
//  AKIDetailNewsView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIDetailNewsView: UIView {

    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var supportView: UIView?
    
    @IBOutlet var imageView: AKIImageView?
    @IBOutlet var contentField: UITextView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func parseContent(content: AKIContent) {
        self.imageView?.imageModel = content.imageModel
        self.contentField?.text = content.dataText
    }
    
    func updateContentFieldSize() {
        
        
        
    }

}

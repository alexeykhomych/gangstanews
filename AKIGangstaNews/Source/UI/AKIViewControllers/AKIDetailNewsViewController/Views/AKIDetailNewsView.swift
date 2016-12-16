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
    
    @IBOutlet var imageVIew: UIImageView?
    @IBOutlet var contentField: UITextView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func parseContent(content: AKIContent) {
//        self.imageVIew? = content.image
        self.contentField?.text = content.dataText
    }
    
    func updateContentFieldSize() {
        
        
        
    }

}

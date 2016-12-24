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
        
        let contentField = self.contentField
        
        do {
            let data = content.dataText?.data(using: String.Encoding.unicode, allowLossyConversion: true)
            contentField?.attributedText = try NSAttributedString(data: data!,
                                                                  options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType],
                                                                  documentAttributes: nil)
        } catch {
            print(error)
        }
    }
}

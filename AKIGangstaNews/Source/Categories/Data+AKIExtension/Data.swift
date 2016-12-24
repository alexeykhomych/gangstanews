//
//  Data.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

extension Data {
    
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

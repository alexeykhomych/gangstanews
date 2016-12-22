//
//  AKIDetailNewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

class AKIDetailNewsContext: AKINewsContext {
    
    var id: String?
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKIDetailNewsRequest)\(self.id!)"
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        guard let dictionary = data[0] as? [String: Any] else { return }
        
        let user = self.model as? AKIUser
        let newsArray = user?.newsArray?.objects
        var content: AKIContent?
        
        for news in newsArray! as! Array<AKIContent> {
            if news.id == self.id {
                content = news
                
                break
            }
        }
        
        content?.dataText = dictionary[kAKIParserDesc] as! String?
    }
}

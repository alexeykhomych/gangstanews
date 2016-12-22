	//
//  AKINewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
    
import RxSwift
import RxCocoa

import Alamofire

class AKINewsContext: AKIContext {
    
    override func headers() -> HTTPHeaders {
        return [
            kAKIContentType: kAKIApplicationJSON,
            kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKINews)"
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        
        let user = self.model as? AKIUser
        let objects = NSMutableArray()
        
        for categoryDictionary in data {
            guard let dictionary = categoryDictionary as? [String : Any] else { return }
            guard let categoriesDictionary = dictionary[kAKIParserCategory] as? [String : Any] else { return }
            
            let content = AKIContent()
            let categoryName = AKICategory(name: categoriesDictionary[kAKIParserTitle] as! String)
            let id = dictionary[kAKIParserID] as? NSNumber
            
            content.id = id?.stringValue
            content.header = dictionary[kAKIParserTitle] as! String?
            content.imageURL = URL.init(string: (dictionary[kAKIParserImageThumb] as! String?)!)
            content.category = categoryName
            objects.add(content)
        }
        
        user?.newsArray?.addObjects(objects)
    }
}

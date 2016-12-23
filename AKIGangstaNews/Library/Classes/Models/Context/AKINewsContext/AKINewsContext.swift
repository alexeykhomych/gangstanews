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
            
            let id = dictionary[kAKIParserID] as? NSNumber
            let content = AKIContent(id: (id?.stringValue)!,
                                     header: (dictionary[kAKIParserTitle] as! String?)!,
                                     dataText: "",
//                                     imageURL: URL(string: (dictionary[kAKIParserImageThumb] as! String?)!)!,
                imageURL: URL(string: "http://cdn.arstechnica.net/wp-content/uploads/2016/02/5718897981_10faa45ac3_b-640x624.jpg")!,
                                     category: AKICategory(name: categoriesDictionary[kAKIParserTitle] as! String))
            
            objects.add(content)
            break
        }
        
        user?.newsArray?.addObjects(objects)
    }
}

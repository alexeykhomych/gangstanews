//
//  AKICategoriesContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

class AKICategoriesContext: AKIContext {
    
    override func headers() -> HTTPHeaders {
        return [
            kAKIContentType: kAKIApplicationJSON,
            kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKICategories)"
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        let user = self.model as? AKIUser
        let categories = user?.categories
        
        for category in data {
            guard let dictionary = category as? [String: Any] else { return }
            categories?.addObject(AKICategory(name: dictionary[kAKIParserTitle]! as! String, selected: true))
        }
    }
}

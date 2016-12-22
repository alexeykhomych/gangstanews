//
//  AKILogoutContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

class AKILogoutContext: AKIContext {
    
    override func headers() -> HTTPHeaders {
        return [
            kAKIContentType: kAKIApplicationJSON,
            kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var method: HTTPMethod? {
        return .post
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKIAuth)/\(kAKILogout)"
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        guard let dictionary = data[0] as? [String: Any] else { return }
        
        let user = self.model as? AKIUser
        user?.authKey = dictionary[kAKIParserAuthKey] as? String
    }
}

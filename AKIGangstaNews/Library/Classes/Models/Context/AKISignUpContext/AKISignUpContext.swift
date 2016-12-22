//
//  AKISignUpContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

class AKISignUpContext: AKIContext {
    
    override func headers() -> HTTPHeaders {
        return [
            kAKIContentType: kAKIApplicationJSON
        ]
    }
    
    override var method: HTTPMethod? {
        return .post
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKISignup)"
    }
    
    override var parameters: [String : String?] {
        let user = self.model as? AKIUser
        
        return [
            kAKIUsername: user?.login,
            kAKIPasswordHash: user?.password,
            kAKIEmail: user?.email
        ]
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        guard let dictionary = data[0] as? [String: Any] else { return }
        
        let user = self.model as? AKIUser
        user?.authKey = dictionary[kAKIParserAuthKey] as? String
    }
}

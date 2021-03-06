//
//  AKILoginContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

class AKILoginContext: AKIContext {
    
    override var headers: HTTPHeaders {
        return [
            kAKIContentType: kAKIApplicationJSON,
            kAKIAuthorization: "\(AuthorizationType.Basic) \(self.accessToken())"
        ]
    }
    
    override var httpMethod: HTTPMethod? {
        return .post
    }
    
    private func accessToken() -> String {
        let user = self.model as? AKIUser
        return self.convertToBase64(email: (user?.email)!, password: (user?.password)!)
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKIAuth)/\(kAKILogin)" as String
    }
    
    override var parameters: [String : String?] {
        let user = self.model as? AKIUser
        
        return [
            kAKIEmail: user?.email,
            kAKIPassword: user?.password
        ]
    }
    
     override func parseJSON(_ json: NSDictionary) {
            guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
            guard let dictionary = data[0] as? [String: Any] else { return }
            
            let user = self.model as? AKIUser
            user?.authKey = dictionary[kAKIParserAuthKey] as? String
    }
    
    private func convertToBase64(email: String, password: String) -> String {
        let plainString = "\(email):\(password)"
        guard let plainData = (plainString as NSString).data(using: String.Encoding.utf8.rawValue) else {
            fatalError()
        }
        
        return (plainData as NSData).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}

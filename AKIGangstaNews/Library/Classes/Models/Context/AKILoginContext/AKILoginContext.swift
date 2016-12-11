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
    
    override func headers() -> HTTPHeaders {
        return [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(AuthorizationType.Basic) \(self.accessToken())"
        ]
    }
    
    private func accessToken() -> String {
        let user = self.model as? AKIUser
        return self.convertToBase64(email: (user?.email)!, password: (user?.password)!)
    }
    
    override var url: String {
        return "\(self.constants.kAKIAPIURL)\(self.constants.kAKIAuth)/\(self.constants.kAKILogin)" as String
    }
    
    override var parameters: [String : String?] {
        let user = self.model as? AKIUser
        
        return [
            self.constants.kAKIEmail: user?.email,
            self.constants.kAKIPassword: user?.password
        ]
    }
    
    public override func observer() -> Observable<(AKIContext)> {
        return Observable<AKIContext>.create { (observer) -> Disposable in
            let requestReference = Alamofire.request(self.url,
                                                     method: self.method,
                                                     parameters: self.parameters,
                                                     encoding: self.encoding,
                                                     headers: self.headers()).responseJSON
                {
                    response in
                
                    switch(response.result) {
                    case .success(_):
                        if let json = response.result.value as? NSDictionary {
                            guard let data = json.object(forKey: self.constants.kAKIData) as? [Any] else { return }
                            guard let dictionary = data[0] as? [String: Any] else { return }
                            
                            let user = self.model as? AKIUser
                            user?.authKey = dictionary[self.constants.kAKIAuthKey] as? String
                            
                            observer.onCompleted()
                            print("login completed")	
                        }
                        break
                        
                    case .failure(_):
                        //                    observer.onError()
                        
                        break
                    }
            }
            
            return Disposables.create(with: { requestReference.cancel() })
        }
    }
    
    private func convertToBase64(email: String, password: String) -> String {
        let plainString = "\(email):\(password)"
        guard let plainData = (plainString as NSString).data(using: String.Encoding.utf8.rawValue) else {
            fatalError()
        }
        
        return (plainData as NSData).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
}

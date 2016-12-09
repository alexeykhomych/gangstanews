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
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var url: String {
        return "\(self.constants.kAKIAPIURL)\(self.constants.kAKILogoutRequest)" as String
    }
    
    public override func observer() -> Observable<(AKIContext)> {
        return Observable<AKIContext>.create { (observer) -> Disposable in
            let requestReference = Alamofire.request(self.url,
                                                     method: self.method,
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
                            print("logout completed")
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
}

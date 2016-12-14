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
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var url: String {
        return "\(self.constants.kAKIAPIURL)\(self.constants.kAKICategories)" as String
    }
    
    override var method: HTTPMethod {
        return .get
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
                            let user = self.model as? AKIUser
                            let categories = user?.categories
                            
                            for category in data {
                                guard let dictionary = category as? [String: Any] else { return }
                                categories?.addObject(AKICategory(name: dictionary["title"]! as! String, enabled: true))
                            }
                            
                            observer.onCompleted()
                            print("category completed")
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

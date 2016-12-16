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
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(AuthorizationType.Bearer) \(((self.model as? AKIUser)?.authKey)!)"
        ]
    }
    
    override var method: HTTPMethod {
        return .get
    }
    
    override var url: String {
        return "\(self.constants.kAKIAPIURL)\(self.constants.kAKINews)" as String
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
                            //modelDidLoad
                            
                            guard let data = json.object(forKey: "data") as? [Any] else { return }
                            
                            let user = self.model as? AKIUser
                            let objects = NSMutableArray()
                            
                            for categoryDictionary in data {
                                guard let dictionary = categoryDictionary as? [String : Any] else { return }
                                guard let categoriesDictionary = dictionary["category"] as? [String : Any] else { return }
                                
                                let content = AKIContent()
                                let categoryName = AKICategory(name: categoriesDictionary["title"] as! String)
                                let id = dictionary["id"] as? NSNumber
                                
                                content.id = id?.stringValue
                                content.header = dictionary["title"] as! String?
                                content.imageURL = dictionary["image_thumb"] as! String?
                                content.category = categoryName
                                objects.add(content)
                            }
                            
                            user?.newsArray?.addObjects(objects)
                            observer.onCompleted()
                            print("news completed")
                        }
                        break
                        
                    case .failure(_):
                        print("modelDidFailLoading")
                        print(response.result.value as Any)
                        break
                        
                    }
            }
            
            return Disposables.create(with: { requestReference.cancel() })
        }
    }
}

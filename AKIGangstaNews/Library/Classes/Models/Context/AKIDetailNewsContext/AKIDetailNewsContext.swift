//
//  AKIDetailNewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

class AKIDetailNewsContext: AKINewsContext {
    
    var id: String?
    
    override var url: String {
        return "\(self.constants.kAKIAPIURL)\(self.constants.kAKIDetailNewsRequest)\(self.id!)" as String
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
                            guard let data = json.object(forKey: "data") as? [Any] else { return }
                            guard let dictionary = data[0] as? [String: Any] else { return }
                            
                            let user = self.model as? AKIUser
                            let newsArray = user?.newsArray
                            var content: AKIContent?
                            
                            for news in (newsArray! as NSArray as! [AKIContent]) {
                                if news.id == self.id {
                                    content = news
                                    
                                    break
                                }
                            }
                            
                            content?.dataText = dictionary["desc"] as! String?
                            observer.onCompleted()
                            print("detailnews completed")
                        }
                        
                        break
                        
                    case .failure(_):
                        print(response.result.value as Any)
                        
                        break
                    }
                }

                return Disposables.create(with: { requestReference.cancel() })
        }
    }    
}

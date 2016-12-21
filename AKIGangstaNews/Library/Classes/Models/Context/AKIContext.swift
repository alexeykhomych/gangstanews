//
//  AKIContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

import Alamofire

public enum AuthorizationType: String {
    case Bearer = "Bearer"
    case Basic = "Basic"
}

class AKIContext {
    
    let constants = AKIConstants()
    
    var model: AnyObject?
    
    var method: HTTPMethod {
        return .post
    }
    
    var url: String {
        return ""
    }
    
    var parameters: [String : String?] {
        return ["" : ""]
    }
    
    var request: Any {
        return ""
    }
    
    func headers() -> HTTPHeaders {
        return [:]
    }
    
    var encoding: JSONEncoding {
        return JSONEncoding.default
    }
    
    func observer() -> Observable<(AKIContext)> {
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
                            self.parseJSON(json)
                            observer.onCompleted()
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
    
    private func parseJSON(_ json: NSDictionary) {

    }
}

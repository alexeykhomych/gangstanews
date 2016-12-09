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
    
    public func observer() -> Observable<(AKIContext)> {
        return Observable<AKIContext>.create { (observer) -> Disposable in
            return Disposables.create(with: {  })
        }
    }
    
}

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

class AKIContext: NSObject {
    var model: AnyObject?
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var url: NSString {
        return ""
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var parameters: [String : String?] {
        return ["" : ""]
    }
    
    var request: Any {
        return ""
    }
    
    public func observer() -> Observable<(AKIContext)> {
        return Observable<AKIContext>.create { (observer) -> Disposable in
            return Disposables.create(with: {  })
        }
    }
    
    public func sendRequest() {
        
    }
    
}

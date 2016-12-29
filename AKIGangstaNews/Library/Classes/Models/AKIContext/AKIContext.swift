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
    
    var model: AnyObject?
    
    var errorMessage: String?
    
    var httpMethod: HTTPMethod? {
        return .get
    }
    
    var url: String? {
        return nil
    }
    
    var parameters: [String : String?]? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var encoding: JSONEncoding {
        return JSONEncoding.default
    }
    
    func execute() {
        DispatchQueue.global().async {
            self.request()
        }
    }
    
    func performExecute() {
        DispatchQueue.main.async {
            self.request()
        }
    }
    
    func request() {
        _ = Alamofire.request(self.url!,
                              method: self.httpMethod!,
                              parameters: self.parameters,
                              encoding: self.encoding,
                              headers: self.headers).responseJSON
            {
                response in
                self.switchResponse(response)
            }
    }
    
    func switchResponse(_ response: Alamofire.DataResponse<Any>) {
        switch(response.result) {
            case .success(_):
                if let json = response.result.value as? NSDictionary {
                    self.parseJSON(json)
                    self.parseCompleted()
                }
                break
                
            case .failure(_):
                self.parseError()
                break
            }
    }
    
    func parseJSON(_ json: NSDictionary) {
        
    }
    
    func parseCompleted() {
        AKIGangstaNewsViewController.observer?.onCompleted()
    }
    
    func parseError() {
        AKIGangstaNewsViewController.observer?.onError(NSError(domain: self.errorMessage!, code: 1, userInfo: nil))
    }
    
    func setErrorMessage(_ json: NSDictionary) {
        let message = (json.object(forKey: kAKIParserData) as? [String: Any])?[kAKIParserMessage] as? String
        self.errorMessage = self.constructMessage(self.parseErrorMessage(message!) as NSArray)
        self.parseError()        
    }
    
    func parseErrorMessage(_ message: String) -> [String] {
        return message.components(separatedBy: "\"")
    }
    
    func constructMessage(_ array: NSArray) -> String {
        let errorSubject = array[1]
        let error = array[5]
        
        return "\(errorSubject) \(error)"
    }
}

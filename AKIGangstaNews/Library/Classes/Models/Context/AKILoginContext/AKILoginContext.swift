//
//  AKILoginContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class AKILoginContext: AKIContext {
    
    let constants = AKIConstants()
    
    
    func loginRequest() {
        
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKILoginRequest)"
        let parameters = [
            self.constants.kAKIEmail: user?.email,
            self.constants.kAKIPassword: user?.password
        ]
        
        let basic = self.convertToBase64(email: (user?.email)!, password: (user?.password)!)

        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(self.constants.kAKIBasicRequest) \(basic)"
        ]
        
        self.request(url: url, parameters: parameters, headers: headers)

    }
    
    public override func observer() -> Observable<(AKIContext)> {
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKILoginRequest)"
        let parameters = [
            self.constants.kAKIEmail: user?.email,
            self.constants.kAKIPassword: user?.password
        ]
        
        let basic = self.convertToBase64(email: (user?.email)!, password: (user?.password)!)
        
        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(self.constants.kAKIBasicRequest) \(basic)"
        ]
        
        
        
        return Observable<AKIContext>.create { (observer) -> Disposable in
            let requestReference = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                print("login")
                switch(response.result) {
                case .success(_):
                    if let json = response.result.value as? NSDictionary {
                        //modelDidLoad
                        
                        guard let data = json.object(forKey: "data") as? [Any] else { return }
                        guard let dictionary = data[0] as? [String: Any] else { return }
                        
                        let user = self.model as? AKIUser
                        user?.authKey = dictionary[self.constants.kAKIAuthKey] as? String
                        
                        print("LOGIN REQUEST COMPLITED")
                        
                        observer.onCompleted()
                    }
                    break
                    
                case .failure(_):
                    print("login request failure")

                    break
                }
            }
            
            return Disposables.create(with: { requestReference.cancel() })
        }
    }

    private func request(url: String, parameters: Parameters, headers: HTTPHeaders) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        
                switch(response.result) {
                    case .success(_):
                        if let json = response.result.value as? NSDictionary {
                        //modelDidLoad
    
                        guard let data = json.object(forKey: "data") as? [Any] else { return }
                        guard let dictionary = data[0] as? [String: Any] else { return }
                            
                        let user = self.model as? AKIUser
                        user?.authKey = dictionary[self.constants.kAKIAuthKey] as? String
                        print("LOGIN REQUEST COMPLITED")
                    }
                    break
    
                case .failure(_):
                    //modelDidFailLoading
                    print(response.result.value as Any)
                break
        
            }
        }
    }
    
    private func convertToBase64(email: String, password: String) -> String {
        let plainString = "\(email):\(password)"
        guard let plainData = (plainString as NSString).data(using: String.Encoding.utf8.rawValue) else {
            fatalError()
        }
        
        return (plainData as NSData).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }

    public override func sendRequest() {
        self.loginRequest()
    }
    
}

//
//  AKISignUpContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKISignUpContext: AKIContext {
    
    let constants = AKIConstants()
    let signUp: String = "signup"
    
    func signUpRequest() {
        let url: String = "\(self.constants.kAKIAPIURL)/\(self.signUp)"
        let parameters = [
            "login": "noob112321",
            "password": "11noob",
            "email": "dsadmawqeil@mail.ua"
        ]
        
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Basic MTFkc2FkbWFpbEBtYWlsLnVhOmdmZ2RnZGdkZ2Q="
//        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    print(response.result.value as Any)
                }
                break
                
            case .failure(_):
                print(response.result.error as Any)
                break
                
            }
        }
        
    }
    
}

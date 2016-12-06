//
//  AKILogoutContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 29.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKILogoutContext: AKIContext {
    
    let constants = AKIConstants()
    
    func logoutRequest() {
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKILogoutRequest)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer uOVPAuYtWCASuCiXupTwQZettDscYjWU="
        ]
        
        self.request(url: url, headers: headers)
    }
    
    private func request(url: String, headers: HTTPHeaders) {
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                if let json = response.result.value as? NSDictionary {
                    //modelDidLoad
                    
                    guard let data = json.object(forKey: "data") as? [Any] else { return }
                    guard let dictionary = data[0] as? [String: Any] else { return }
                    
                    let user = self.model as? AKIUser
                    user?.authKey = dictionary[self.constants.kAKIAuthKey] as? String
                }
                break
                
            case .failure(_):
                //modelDidFailLoading
                print(response.result.value as Any)
                break
                
            }
        }
    }
}

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

    let logout: String = "auth/logout"
    let constants = AKIConstants()
    
    func logoutRequest() {
        let url: String = "\(self.constants.kAKIAPIURL)/\(self.logout)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer uOVPAuYtWCASuCiXupTwQZettDscYjWU="
        ]
        
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
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

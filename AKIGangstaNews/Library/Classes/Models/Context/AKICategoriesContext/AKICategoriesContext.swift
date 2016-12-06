//
//  AKICategoriesContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKICategoriesContext: AKIContext {

    let constants = AKIConstants()
    
    func categoriesRequest() {
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKICategoriesRequest)"
        
        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
            self.constants.kAKIAuthorization: "\(self.constants.kAKIBearerRequest) \(user?.authKey)"
        ]
        
        self.request(url: url, headers: headers)
        
    }
    
    private func request(url: String, headers: HTTPHeaders) {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                if let json = response.result.value as? NSDictionary {
                    //modelDidLoad
                    
                    guard let data = json.object(forKey: "data") as? [Any] else { return }
                    guard let dictionary = data[0] as? [String: Any] else { return }
                    
                    let user = self.model as? AKIUser
                    
                    user?.login = dictionary[self.constants.kAKIUsername] as? String
                    
                    for category in dictionary {
                        print(category)
//                        user?.newsCategories += category
                    }
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

/*
 {
 "success": true,
 "data": [
 {
 "id": 1,
 "title": "World"
 },
 {
 "id": 2,
 "title": "Politics"
 },
 {
 "id": 3,
 "title": "Business"
 },
 {
 "id": 4,
 "title": "Tech"
 },
 {
 "id": 5,
 "title": "Science"
 },
 {
 "id": 6,
 "title": "Arts"
 },
 {
 "id": 7,
 "title": "Travel"
 }
 ]
 }
 */
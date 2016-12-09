//
//  AKIDetailNewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKIDetailNewsContext: AKIContext {

    let constants = AKIConstants()
    var id: String?
    
    func detailNewsRequest() {
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKIDetailNewsRequest)\(self.id as AnyObject)"
        
        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
//            self.constants.kAKIAuthorization: "\(self.constants.kAKIBearerRequest) \(user?.authKey)"
            self.constants.kAKIAuthorization: "Bearer UmPblB9MPejCtetfQOH49rtfO-VtpIrC"
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
                    let newsArray = user?.newsArray
                    var content: AKIContent?
                    
                    for news in (newsArray! as NSArray as! [AKIContent]) {
                        if news.id == self.id {
                            content = news
                            
                            break
                        }
                    }
                    
                    content?.dataText = dictionary["desc"] as! String?
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
 "title": "One by One, ISIS Social Media Experts Are Killed as Result of F.B.I. Program",
 "short_desc": "American officials say a secretive campaign of surveillance and drone attacks has cut the Islamic State’s ability to inspire attacks in the West.",
 "desc": "<p>WASHINGTON — In the summer of 2015, armed American drones over eastern Syria stalked Junaid Hussain, an influential hacker and recruiter for the Islamic State.</p>\n                 <p>For weeks, Mr. Hussain was careful to keep his young stepson by his side, and the drones held their fire. But late one night, Mr. Hussain left an internet cafe alone, and minutes later a Hellfire missile killed him as he walked between two buildings in Raqqa, Syria, the Islamic State’s de facto capital.</p>\n                 <p>Mr. Hussain, a 21-year-old from Birmingham, England, was a leader of a band of English-speaking computer specialists who had given a far-reaching megaphone to Islamic State propaganda and exhorted online followers to carry out attacks in the West. One by one, American and allied forces have killed the most important of roughly a dozen members of the cell, which the F.B.I. calls “the Legion,” as part of a secretive campaign that has largely silenced a powerful voice that led to a surge of counterterrorism activity across the United States in 2015 as young men and women came under the influence of its propaganda.</p>\n                 <p>American military, intelligence and law enforcement officials acknowledge that the Islamic State still retains a sophisticated social media arm that could still inspire attacks like those in San Bernardino, Calif., and in Orlando, Fla., and remains a potent foe suspected of maintaining clandestine cells in Europe. But they point to the coordinated effort against the Legion as evidence of the success the United States has had in reducing the Islamic State’s ability to direct, enable or inspire attacks against the West.</p>\n                ",
 "image": "images/news/1/full.jpg",
 "category_id": 1,
 "created_at": null,
 "image_thumb": "images/news/1/thumb.jpg"
 }
 ]
 }
 */

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
    var url: String?
    let disposeBag = DisposeBag()
    
    //    private var loginUser: Observable<AKIUser>
    //    let headers: HTTPHeaders? = nil
    
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
    
    private func login() {
        Observable<NSDate>.create { (observer) -> Disposable in
            DispatchQueue.global().async {
                self.loginRequest()
            }
            return self.disposeBag as! Disposable
            
            }.subscribe(onNext: { model in
                self.model = model
            },onError: { error in
                print(error)
            })
            .addDisposableTo(disposeBag)
        
    }
    
//    private func fetchRepositories() -> Driver<[Repository]> {
//        return repositoryName
//            .subscribeOn(MainScheduler.instance) // Make sure we are on MainScheduler
//            .doOn(onNext: { response in
//                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//            })
//            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
//            .flatMapLatest { text in // .Background thread, network request
//                return RxAlamofire
//                    .requestJSON(.GET, "https://api.github.com/users/\(text)/repos")
//                    .debug()
//                    .catchError { error in
//                        return Observable.never()
//                }
//            }
//            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
//            .map { (response, json) -> [Repository] in // again back to .Background, map objects
//                if let repos = Mapper<Repository>().mapArray(json) {
//                    return repos
//                } else {
//                    return []
//                }
//            }
//            .observeOn(MainScheduler.instance) // switch to MainScheduler, UI updates
//            .doOn(onNext: { response in
//                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            })
//            .asDriver(onErrorJustReturn: []) // This also makes sure that we are on MainScheduler
//    }
}

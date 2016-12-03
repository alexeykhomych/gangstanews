//
//  AKIObserver.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 02.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AKIObserver {

    enum Example {
        case modelDidLoad
        case modelWillLoad
        case modelDidFailLoading
    }
    
    var state: Example?
    
    public func addObserver(observer: AKIObserver) {
        
    }
    
    func createGoogleDataObservable() -> Observable<AKIObserver> {
        
        return Observable<AKIObserver>.create({ (observer) -> Disposable in
            
            
            
            return Disposables.create {
                //Cancel the connection if disposed
            
            }
        })
    }

}

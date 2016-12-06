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
    
    public func Subscribe(observer: AnyObject) {
        var observer = observer
        observer = self.createGoogleDataObservable()
    }
    
    public func Unsubscribe(observer: AnyObject) {
        
    }
    
    func createGoogleDataObservable() -> Observable<String> {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        
        // As you can see the subject casts nicely, because it's an Observable subclass
        let observable : Observable<String> = subject
        
        observable
            .subscribe(onNext: { text in
                print(text)
            })
            .addDisposableTo(disposeBag)
        
        // You can call onNext any time you want to emit a new item in the sequence
        subject.onNext("Hey!")
        subject.onNext("I'm back!")
        
        
        
        return observable
    }

}

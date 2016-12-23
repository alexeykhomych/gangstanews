//
//  AKIImageModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 16.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKIImageModel: AKIModel {
    
    var image: UIImage? = nil
    var url: URL? = nil
    
//    var observer: Observable<AKIImageModel> {
//        return self.observer(self)
//    }
    
    static func imageWithURL(_ url: URL) -> AKIImageModel {
        let model = AKIModelCache.shared.objectForKey(url as AnyObject)
        if model != nil {
            return model!
        }
        
        let classType = url.isFileURL ? AKILocalImageModel(url) : AKIInternetImageModel(url as URL)
        
        return classType
    }
    
    init(_ url: URL) {
        super.init()
        self.url = url
        AKIModelCache.shared.addObject(self)
    }
    
    func finishLoadingImage(_ loadedImage: UIImage) {
        self.image = loadedImage
        AKIImageView.obsr?.onCompleted()
    }
    
//    func observer() -> PublishSubject<AKIImageModel> {
//        return PublishSubject<AKIImageModel>()
//        //        return PublishSubject<AKIImageModel>.create { (observer) -> Disposable in
////            print("observer")
////            print(model)
////            model.load()
////            observer.onCompleted()
////            
////            return Disposables.create(with: {  })
////        }
//        
////        let observable = Observable<Int>.create { (observer) -> Disposable in
////            observer.onNext(1)
////            return NopDisposable.instance
////        }
////        
////        let boolObservable : Observable<Bool> = observable.map { (element) -> Bool in
////            if (element == 0) {
////                return false
////            } else {
////                return true
////            }
////        }
////        
////        boolObservable.subscribeNext { (boolElement) in
////            print(boolElement)
////            }.addDisposableTo(disposeBag)
//    }
}

//
//  AKISpinnerViewContainer.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKISpinnerViewContainer: AKIView {
    
    static var observer: PublishSubject<AKIModel>?
    let disposeBag = DisposeBag()

    var model: AKIModel? {
        willSet(newModel) {            
            self.model = newModel
//            self.setObserver(newModel!)
        }
    }
    
    static func viewWithFrame(_ frame: CGRect) -> AKISpinnerViewContainer {
        return AKISpinnerViewContainer.init(frame: frame)
    }
    
    func modelWillLoad() {
        DispatchQueue.main.async {
            self.spinnerViewVisible = true
        }
    }
    
    func modelDidLoad() {
        DispatchQueue.main.async {
            self.spinnerViewVisible = false
            print("modelDidLoad - spinner")
        }
    }
    
    func modelFailLoading() {
        DispatchQueue.main.async {
            self.spinnerViewVisible = false
        }
    }
    
    func setObserver(_ model: AKIModel) {
        AKISpinnerViewContainer.observer = PublishSubject<AKIModel>()
        AKISpinnerViewContainer.observer?.subscribe(onNext: { model in
            self.modelWillLoad()
        }, onError: { error in
            self.modelFailLoading()
        }, onCompleted: {
            self.modelDidLoad()
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
}

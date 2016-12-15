//
//  AKIDetailNewsViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKIDetailNewsViewController: AKIGangstaNewsViewController {
    
    var content: AKIContent?

    var detailNewsView: AKIDetailNewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadContext() {
        let user = self.user
        
        let context = AKIDetailNewsContext()
        context.model = user
        context.id = (self.model as? AKIContent)?.id
        let observer = context.observer()
        self.user = user
        
        observer.subscribe(onNext: { next in
            print(next)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            self.modelDidLoad()
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
    
    override func modelDidLoad() {
        self.detailNewsView?.parseContent(content: self.model as! AKIContent)
    }
    
}

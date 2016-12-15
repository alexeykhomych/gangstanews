//
//  AKIGangstaNewsViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxKeyboard

class AKIGangstaNewsViewController: AKIAbstractViewController {
    
    let disposeBag = DisposeBag()

    var user: AKIUser?
    var context: AKIContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func modelDidLoad() {
        print("modelDidLoad")
    }
    
    func keyboardObserver(_ scrollView: UIScrollView) {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                scrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .addDisposableTo(disposeBag)
    }
    
}

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

let kAKIErrorTitle = "Error message"
let kAKIErrorMessage = "You use illegal characters"
let kAKIErrorButtonText = "Ok"

class AKIGangstaNewsViewController: AKIAbstractViewController {
    
    static var observer: PublishSubject<AKIContext>?
    
    let disposeBag = DisposeBag()
    var context: AKIContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func modelDidLoad() {
        
    }
    
    func modelDidFailLoading() {
        
    }
    
    func modelWillLoading() {
        
    }
    
    var spinnerContainer: AKISpinnerViewContainer? {
        return self.getView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let model = self.context
//        self.spinnerContainer?.model = model
//        AKIGangstaNewsViewController.observer?.onNext(model!)
    }
    
    func keyboardObserver(_ scrollView: UIScrollView) {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                scrollView.contentInset.bottom = keyboardVisibleHeight
                self?.view.setNeedsLayout()
                UIView.animate(withDuration: 0) {
                    self?.view.layoutIfNeeded()
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func saveDataToDisk(data: AnyObject, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadDataFromDisk(key: String) -> AnyObject? {
        return UserDefaults.standard.string(forKey: key) as AnyObject
    }
    
    @IBAction func tapGestureRecognizer(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func pushViewController(_ viewController: AKIGangstaNewsViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushViewController(_ viewController: AKIGangstaNewsViewController, model: AKIUser) {
        DispatchQueue.main.async {
            viewController.model = model
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func synced(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }

    func setObserver(_ context: AKIContext) {
        AKIGangstaNewsViewController.observer = PublishSubject<AKIContext>()
        AKIGangstaNewsViewController.observer?.subscribe(onNext: { context in
            self.modelWillLoading()
            context.execute()
        }, onError: { error in
            self.showErrorAllert(message: context.errorMessage!)
            self.modelDidFailLoading()
        }, onCompleted: {
            self.modelDidLoad()
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
        
        AKIGangstaNewsViewController.observer?.onNext(context)
    }
    
    func showErrorAllert(message: String) {
        let alert = UIAlertController(title: kAKIErrorTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: kAKIErrorButtonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

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
        viewController.model = model
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

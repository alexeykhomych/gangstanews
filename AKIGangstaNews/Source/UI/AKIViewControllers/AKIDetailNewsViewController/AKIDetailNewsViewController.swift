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

class AKIDetailNewsViewController: AKIGangstaNewsViewController, UITextViewDelegate {
    
    var content: AKIContent?

    var detailNewsView: AKIDetailNewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailNewsView?.contentField?.delegate = self
        
        self.loadContext()        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
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
        let textView = self.detailNewsView?.contentField
        self.detailNewsView?.parseContent(content: self.model as! AKIContent)
        
        let fixedWidth = textView?.frame.size.width
        textView?.sizeThatFits(CGSize(width: fixedWidth!, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView?.sizeThatFits(CGSize(width: fixedWidth!, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView?.frame
        newFrame?.size = CGSize(width: max((newSize?.width)!, fixedWidth!), height: (newSize?.height)!)
        textView?.frame = newFrame!
        
        self.detailNewsView?.scrollView?.layoutIfNeeded()
        self.detailNewsView?.scrollView?.contentSize.height = (self.detailNewsView?.scrollView?.contentSize.height)! + (textView?.bounds.size.height)!
    }
    
}

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
        let context = AKIDetailNewsContext()
        context.model = self.model as! AKIUser?
        context.id = self.content?.id
        self.setObserver(context)
    }
    
    override func modelDidLoad() {
        self.detailNewsView?.parseContent(content: self.content!)
        self.detailNewsView?.spinnerView?.visible = false
        self.resizeScrollView()
    }
    
    private func resizeScrollView() {
        let detailNewsView = self.detailNewsView
        
        let scrollView = detailNewsView?.scrollView
        let textView = detailNewsView?.contentField
        
        let fixedWidth = textView?.frame.size.width
        textView?.sizeThatFits(CGSize(width: fixedWidth!, height: CGFloat.greatestFiniteMagnitude))
        
        let newSize = textView?.sizeThatFits(CGSize(width: fixedWidth!, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView?.frame
        
        newFrame?.size = CGSize(width: max((newSize?.width)!, fixedWidth!), height: (newSize?.height)!)
        textView?.frame = newFrame!
        
        scrollView?.layoutIfNeeded()
        scrollView?.contentSize.height = (scrollView?.contentSize.height)! + (textView?.bounds.size.height)!
    }
}

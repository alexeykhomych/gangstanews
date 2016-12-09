//
//  AKIDetailNewsViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIDetailNewsViewController: AKIAbstractViewController {
    
    var content: AKIContent?
    var context: AKIDetailNewsContext?
    var user: AKIUser?

    var detailNewsView: AKIDetailNewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContext()
        self.parseNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func parseNews() {
//        self.detailNewsView?.parseContent(content: self.content!)
    }

    private func loadContext() {
        let context = AKIDetailNewsContext()
        self.context = context
        
        context.model = self.user
        context.id = (self.model as? AKIContent)?.id
        context.detailNewsRequest()
    }
    
}

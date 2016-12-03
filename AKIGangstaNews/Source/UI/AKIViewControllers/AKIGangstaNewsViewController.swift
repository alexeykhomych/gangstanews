//
//  AKIGangstaNewsViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIGangstaNewsViewController: AKIAbstractViewController {

    var user: AKIUser? {
        get {
            return self.user
        } set(newUser) {
            self.user = newUser
        }
    }
    
    var context: AKIContext? {
        get {
            return self.context
        } set(newContext) {
            self.context = newContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startObserving(object: AnyObject) {
        NotificationCenter.default.addObserver(self, selector: #selector(modelDidLoad), name: NSNotification.Name(rawValue: "modelDidLoad"), object: nil)
    }
    
    func stopObserving() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func modelDidLoad() {
        print("modelDidLoad")
    }
    
}

//
//  AKIConfirmEmailViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIConfirmEmailViewController: AKIAbstractViewController {
    
    var confirmEmailView: AKIConfirmEmailView? {
        return self.getView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendButton(_ sender: UIButton) {
        self.pushViewController(AKIRestorePasswordViewController())
    }

}

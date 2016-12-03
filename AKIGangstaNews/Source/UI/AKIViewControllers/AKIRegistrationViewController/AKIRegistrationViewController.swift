//
//  AKIRegistrationViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 23.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIRegistrationViewController: AKIAbstractViewController {
    
    let signUpContext = AKISignUpContext()
    
    var registrationView: AKIRegistrationView? {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - View Lifecycle
    
    @IBAction func registrationButton(_ sender: UIButton) {
        self.signUpContext.signUpRequest()
        _ = self.navigationController?.popViewController(animated: true)
    }

}

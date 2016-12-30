//
//  AKIView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIView: UIView {

    @IBOutlet var spinnerView: AKISpinnerView? {
        willSet(newSpinnerView) {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = newSpinnerView
            self.addSubview(newSpinnerView!)
        }
    }
    
    var spinnerViewVisible: Bool? {
        get {
            return self.spinnerView?.visible
        } set (newValue) {
            self.spinnerView?.visible = newValue
        }
    }
    
    var defaultSpinnerView: AKISpinnerView? {
        return AKISpinnerView.loadingViewInSuperview(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.spinnerView = self.defaultSpinnerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.spinnerView == nil {
            self.spinnerView = self.defaultSpinnerView
        }
    }
}

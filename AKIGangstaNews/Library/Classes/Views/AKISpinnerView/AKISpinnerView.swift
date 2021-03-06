//
//  AKISpinnerView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

let kAKIDuration = 1.0

class AKISpinnerView: UIView {

    @IBOutlet var spinnerView: UIActivityIndicatorView?
    var visible: Bool? {
        get {
            return self.spinnerView?.isHidden
        } set (newValue) {
            self.setVisible(newValue!)
        }
    }
    
    static func loadingViewInSuperview(_ superview: UIView) -> AKISpinnerView {
        let view = Bundle.objectWithClass(AKISpinnerView.self) as! AKISpinnerView
        view.frame = superview.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setVisible(_ visible: Bool) {
        self.setVisible(visible, animated: true)
    }
    
    var block: (() -> Void)?
    
    func setVisible(_ visible: Bool, animated: Bool) {
        self.setVisible(visible, animated: animated, completionHandler: {_ in
            if !visible {
                self.removeFromSuperview()
            }
        })
    }
    
    func setVisible(_ visible: Bool, animated: Bool, completionHandler: @escaping (Bool) -> Void) {
        self.superview?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: animated ? kAKIDuration : 0,
                       animations: {
                            self.alpha = visible ? 1.0 : 0
                        },
                       completion:  { shouldFinish in
                            if !visible {
                                completionHandler(visible)
                            }
                        })
    }
}

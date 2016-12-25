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
        willSet(newValue) {
            self.setVisible(newValue!)
            self.visible = newValue
        }
    }
    
    static func loadingViewInSuperview(_ superview: UIView) -> AKISpinnerView {
        let view = Bundle.objectWithClass(AKISpinnerView.self) as! AKISpinnerView
        view.frame = superview.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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
    
    func setVisible(_ visible: Bool, animated: Bool) {
        self.setVisible(visible, animated: animated, completionHandler: { value in
            if !value {
                self.removeFromSuperview()
            }
        })
    }
    
    func setVisible(_ visible: Bool, animated: Bool, completionHandler: @escaping (_ finished: Bool) -> Void) {
        let result = animated ? kAKIDuration : 0
        let result2 = visible ? kAKIDuration : 0
        self.superview?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: result,
                       animations: {
                            self.alpha = CGFloat(result2)
                        },
                       completion:  { (finished: Bool) -> Void in
                            self.visible = visible
                            completionHandler(visible)                                
                        })
    }

}

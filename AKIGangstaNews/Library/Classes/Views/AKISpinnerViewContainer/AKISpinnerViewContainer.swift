//
//  AKISpinnerViewContainer.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKISpinnerViewContainer: AKIView {
    
    static func viewWithFrame(_ frame: CGRect) -> AKISpinnerViewContainer {
        return AKISpinnerViewContainer.init(frame: frame)
    }
    
    func modelWillLoad() {
        DispatchQueue.main.async {
            self.spinnerViewVisible = true
        }
    }
    
    func modelDidLoad() {
        DispatchQueue.main.async {
            self.spinnerViewVisible = false
        }
    }
    
    func modelFailLoading() {
        DispatchQueue.main.async {
            self.spinnerViewVisible = false
        }
    }
}

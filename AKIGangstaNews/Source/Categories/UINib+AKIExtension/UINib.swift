//
//  Nib.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 25.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

extension UINib {
    
    static func objectWithClass(_ cls: AnyClass) -> AnyObject {
        let nib = UINib.nibWithClass(cls)
        return nib.objectWithClass(cls)
    }
    
    static func nibWithClass(_ cls: AnyClass) -> UINib {
        return self.nibWithClass(cls, bundle: nil)
    }
    
    static func nibWithClass(_ cls: AnyClass, bundle: Bundle?) -> UINib {
        return self.init(nibName: String(describing: cls.self), bundle: bundle)
    }
    
    func objectWithClass(_ cls: AnyClass) -> AnyObject {
        return self.objectWithClass(cls, owner: nil)
    }
    
    func objectWithClass(_ cls: AnyClass, owner: AnyObject?) -> AnyObject {
        return self.objectWithClass(cls, owner: owner, options: nil)
    }
    
    func objectWithClass(_ cls: AnyClass, owner: AnyObject?, options: NSDictionary?) -> AnyObject {
        return (self.instantiate(withOwner: owner, options: (options as? [AnyHashable : Any])) as NSArray?)?.objectWithClass(cls) as AnyObject
    }
    
}

//
//  NSArray.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

extension NSArray {
    
    func objectWithClass(_ cls: AnyClass) -> Any? {
        for object in self {
            if type(of: object) == cls.self {
                return object
            }
        }
        
        return nil
    }
    
}

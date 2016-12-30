//
//  String.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 24.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

extension String {
    
    var utf8Data: Data? {
        return data(using: .utf8)
    }
}

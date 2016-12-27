//
//  AKILocalImageModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 16.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKILocalImageModel: AKIImageModel {

    override func performLoading() {
        self.finishLoadingImage(self.loadImageAtURL(self.url! as URL)!)
    }
    
    public func loadImageAtURL(_ url: URL) -> UIImage? {
        print("\(url.absoluteString)")
        return UIImage(named: url.absoluteString)
    }
}

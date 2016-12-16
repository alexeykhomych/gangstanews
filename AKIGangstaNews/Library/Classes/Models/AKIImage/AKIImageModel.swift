//
//  AKIImageModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 16.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIImageModel: AKIModel {
    
    var image: UIImage? = nil
    var url: NSURL? = nil
    
    func imageWithURL(_ url: NSURL) -> AKIImageModel {
        let cache = AKIModelCache()
        let model = cache.objectForKey(url as URL) as? AKIImageModel
        if model != nil {
            return model!
        }
        
        let classType = url.isFileURL ? AKILocalImageModel(url) : AKIInternetImageModel(url)
        
        return classType
    }
    
    init(_ url: NSURL) {
        super.init()
        self.url = url
        AKIModelCache.shared.addObject(self)
    }
    
    func finishLoadingImage(_ loadedImage: UIImage) {
        self.image = loadedImage
    }
    
    func loadImageAtURL(_ url: NSURL) -> UIImage? {
        return nil
    }
}

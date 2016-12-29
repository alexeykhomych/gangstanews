//
//  AKIImageModel.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 16.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKIImageModel: AKIModel {
    
    var image: UIImage? = nil
    var url: URL? = nil
    
    static func imageWithURL(_ url: URL) -> AKIImageModel {
        let model = AKIModelCache.shared.objectForKey(url as AnyObject)
        if model != nil {
            return model!
        }
        
        let classType = url.isFileURL ? AKILocalImageModel(url) : AKIInternetImageModel(url as URL)
        
        return classType
    }
    
    init(_ url: URL) {
        super.init()
        self.url = url
        AKIModelCache.shared.addObject(self)
    }
    
    func finishLoadingImage(_ loadedImage: UIImage) {
        self.image = loadedImage
        if self.image != nil {
//            AKIImageView.obsr?.onCompleted()
//            AKIImageView.observable?.asObservable().onCompleted()
        } else {
            print("didn't load")
        }
        
    }
}

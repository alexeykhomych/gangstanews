//
//  AKIContent.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 01.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AKIContent: NSCopying, NSCoding {
    
    public var id: String?
    public var header: String?
    public var dataText: String?
    public var imageURL: URL?
    public var imageURLThumb: String?
    public var category: AKICategory?
    
    var imageModel: AKIImageModel? {
        return AKIImageModel.imageWithURL(self.imageURL!)
    }
    
    init(id: String, header: String, dataText: String, imageURL: URL, category: AKICategory) {
        self.id = id
        self.header = header
        self.dataText = dataText
        self.category = category
        self.imageURL = imageURL
    }
    
    public required init?(coder aDecoder: NSCoder){
        self.id = self.decode(decoder: aDecoder, key: kAKIID)
        self.header = self.decode(decoder: aDecoder, key: kAKIHeader)
        self.dataText = self.decode(decoder: aDecoder, key: kAKIDataText)
    }
    
    public func encode(with aCoder: NSCoder) {
        self.encode(encoder: aCoder, field: self.id!, key: kAKIID)
        self.encode(encoder: aCoder, field: self.header!, key: kAKIHeader)
        self.encode(encoder: aCoder, field: self.dataText!, key: kAKIDataText)
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return AKIContent(id: self.id!, header: self.header!, dataText: self.dataText!, imageURL: self.imageURL!, category: self.category!)
    }
    
    //MARK: Private
    
    private func decode(decoder: NSCoder, key: String) -> String {
        return decoder.decodeObject(forKey: key) as! String
    }
    
    private func encode(encoder: NSCoder, field: String, key: String) {
        encoder.encode(field, forKey: key)
    }

}

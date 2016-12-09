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

class AKIContent: NSObject {
    
    public var id: String?
    public var header: String?
    public var dataText: String?
    public var image: UIImageView?
    
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        self.header = ""
        self.dataText = ""
        self.image = nil
    }
    
    init(header: String, dataText: String, image: UIImageView) {
        self.header = header
        self.dataText = dataText
        self.image = image
    }

}

class AKIContentModel {
    
    private let content: AKIContent
    
    public var header: BehaviorSubject<String>
    public var dataText: BehaviorSubject<String>
    public var image: BehaviorSubject<UIImageView>
    
    let disposeBag = DisposeBag()
    
    init(content: AKIContent) {
        self.content = content
        
        self.dataText = BehaviorSubject<String>(value: content.dataText!)
        self.header = BehaviorSubject<String>(value: content.header!)
        self.image = BehaviorSubject<UIImageView>(value: content.image!)
        
        self.dataText.subscribe(onNext: { (dataText) in
            content.dataText = dataText
        }).addDisposableTo(self.disposeBag)
        
        self.header.subscribe(onNext: { (header) in
            content.header = header
        }).addDisposableTo(self.disposeBag)
        
        self.header.subscribe(onNext: { (image) in
//            content.image = image as? UIImageView
        }).addDisposableTo(self.disposeBag)
        
    }
    
}

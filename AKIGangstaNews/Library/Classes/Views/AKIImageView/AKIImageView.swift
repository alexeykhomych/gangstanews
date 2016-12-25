
//  AKIImageView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 19.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKIImageView: AKISpinnerViewContainer {
    
    static var obsr: PublishSubject<AKIImageModel>? = nil
    
    @IBOutlet var imageView: UIImageView? {
        willSet(newImageView) {
            if self.imageView != newImageView {
                self.imageView?.removeFromSuperview()
                self.imageView = newImageView
                self.addSubview(newImageView!)
            }
        }
    }
    
    var imageModel: AKIImageModel? = nil {
        willSet(value) {
            self.imageModel = value
            self.model = value
            self.loadImageModel()
        }
    }
    
    //MARK: Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubviews()
    }
    
    func initSubviews() {
        let imageView = UIImageView.init(frame: self.bounds)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.imageView = imageView
    }
    
    //MARK: Views Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.imageView == nil {
            self.initSubviews()
        }
    }
    
    func modelDidLoad(_ model: AKIImageModel) {
        DispatchQueue.main.async {
            self.imageView?.image = model.image
            print("modelDidLoad - imageview")
            super.modelDidLoad()
        }
    }
    
    private func loadImageModel() {
        var imageModel = self.imageModel
        AKIImageView.obsr = PublishSubject<AKIImageModel>()
        AKIImageView.obsr?.subscribe(onNext: { model in
            imageModel = model
            model.load()
        }, onError: { error in
            print(error)
        }, onCompleted: {
            self.modelDidLoad(imageModel!)
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
        
        AKIImageView.obsr?.onNext(imageModel!)
    }
    
    func synced(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}

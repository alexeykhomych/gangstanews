//
//  AKIImageView.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 19.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKIImageView: UIView {
    
    let disposeBag = DisposeBag()
    static var observable: Variable<AKIImageModel>? = nil
    @IBOutlet var imageView: UIImageView?
    var imageModel: AKIImageModel? = nil {
        willSet(value) {
            self.imageModel = value
//            self.imageModel?.load()
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
//        DispatchQueue.main.async {
            self.imageView?.image = model.image
//        }
    }
    
    private func loadImageModel() {
        let observer = self.imageModel?.observer((self.imageModel)!)
        var model: AKIImageModel?
        observer?.subscribe(onNext: { next in
            print(next)
        }, onError: { error in
            print(error)
        }, onCompleted: { completed in
            print(completed)
            self.modelDidLoad(self.imageModel!)
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
        
//        var m: AKIImageModel? = nil
//        let image = Variable(AKIImageModel.imageWithURL((self.imageModel?.url)!))
//        AKIImageView.observable = image.asObservable()
//            .subscribe(onNext: { model in
//                m = model
//                model.load()
//            }, onCompleted: { model in
//                self.modelDidLoad(m!)
//            }) as? Variable<AKIImageModel>
        
        
    }
}

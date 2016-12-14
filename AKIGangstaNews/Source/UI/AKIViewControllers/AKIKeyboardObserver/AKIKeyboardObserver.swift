
//
//  AKIKeyboardObserver.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 14.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

public final class AKIKeyboardObserver {
    
    public struct KeyboardInfo {
        
        public let frameBegin: CGRect
        public let frameEnd: CGRect
        
        init(notification: NSNotification) {
            let frameEnd = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            let frameBegin = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
            self.frameBegin = frameBegin!
            self.frameEnd = frameEnd!
        }
    }
    
    public let willChangeFrame = PublishSubject<KeyboardInfo>()
    public let didChangeFrame = PublishSubject<KeyboardInfo>()
    
    public let willShow = PublishSubject<KeyboardInfo>()
    public let didShow = PublishSubject<KeyboardInfo>()
    public let willHide = PublishSubject<KeyboardInfo>()
    public let didHide = PublishSubject<KeyboardInfo>()
    
    public init() {
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardWillChangeFrame)
            .map { KeyboardInfo(notification: $0 as NSNotification) }
            .bindTo(self.willChangeFrame)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardDidChangeFrame)
            .map { KeyboardInfo(notification: $0 as NSNotification) }
            .bindTo(self.didChangeFrame)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardWillShow)
            .map { KeyboardInfo(notification: $0 as NSNotification) }
            .bindTo(self.willShow)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardDidShow)
            .map { KeyboardInfo(notification: $0 as NSNotification) }
            .bindTo(self.didShow)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardWillHide)
            .map { KeyboardInfo(notification: $0 as NSNotification) }
            .bindTo(self.willHide)
            .addDisposableTo(self.disposeBag)
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name.UIKeyboardDidHide)
            .map { KeyboardInfo(notification: $0 as NSNotification) }
            .bindTo(self.didHide)
            .addDisposableTo(self.disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}

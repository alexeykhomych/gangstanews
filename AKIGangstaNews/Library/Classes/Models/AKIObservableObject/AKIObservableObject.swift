//
//  AKIObservableObject.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 26.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKIObservableObject: NSObject {
    
    var observers: NSSet? {
        return self.observersTable?.setRepresentation as NSSet?
    }
    var state: Int?
    
    private var observersTable: NSHashTable<AnyObject>?
    private var notifyObservers: Bool?
    
    override init() {
        super.init()
        self.observersTable = NSHashTable.weakObjects()
        self.notifyObservers = true
    }
    
    func setState(_ state: Int) {
        self.setState(state, withObject: nil)
    }
    
    func setState(_ state: Int, withObject: AnyObject?) {
        if self.state != state {
            self.state = state
            
            self.notifyOfState(state, withObject: withObject)
        }
    }
    
    func addObserver(_ object: AnyObject) {
        self.observersTable?.add(object)
    }
    
    func addObservers(_ observers: NSArray) {
        for observer in observers {
            self.addObserver(observer as AnyObject)
        }
    }
    
    func removeObserver(_ observer: AnyObject) {
        self.observersTable?.remove(observer)
    }
    
    func removeObservers(_ observers: NSArray) {
        for observer in observers {
            self.removeObserver(observer as AnyObject)
        }
    }
    
    func containsObserver(_ observer: AnyObject) {
        self.observersTable?.contains(observer)
    }
    
    func selectorForState(_ state: Int) -> Selector? {
        return nil
    }
    
    func notifyOfState(_ state: Int) {
        self.notifyOfState(state, withObject: nil)
    }
    
    func notifyOfState(_ state: Int, withObject: AnyObject?) {
        self.notifyObserverWithSelector(self.selectorForState(self.state!)!, object: withObject!)
    }
    
    func performBlock(_ block: (Void) -> Void, should notify: Bool) {
        let currentNotifyObservers = self.notifyObservers
        self.notifyObservers = notify
        block()
        self.notifyObservers = currentNotifyObservers
    }
    
    func notifyObserverWithSelector(_ selector: Selector, object: AnyObject) {
        if !self.notifyObservers! {
            return
        }
        
//        let observers = self.observersTable?.allObjects
//        for observer in observers! {
//            if  {
//                observer.#selector
////            }
//        }
    }
    
}

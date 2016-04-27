//
//  BDUserDefaults.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/27.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

private let userIDKey = "userID"
private let usernameKey = "username"

// MARK:- Generics
// use generics to listen the change of object
struct Listener<T>: Hashable {
    let name: String
    
    typealias Action = T -> Void
    let action: Action
    
    var hashValue: Int {
        return name.hashValue
    }
}

func ==<T>(lhs: Listener<T>, rhs: Listener<T>) -> Bool {
    return lhs.name == rhs.name
}

class Listenable<T> {
    var value: T {
        didSet {
            setterAction(value)
            
            for listener in listenerSet {
                listener.action(value)
            }
        }
    }
    
    typealias SetterAction = T -> Void
    var setterAction: SetterAction
    
    var listenerSet = Set<Listener<T>>()
    
    func bindListener(name: String, action: Listener<T>.Action) {
        let listener = Listener(name: name, action: action)
        
        listenerSet.insert(listener)
    }
    
    func bindAndFireListener(name: String, action: Listener<T>.Action) {
        bindListener(name, action: action)
        
        action(value)
    }
    
    func removeListenerWithName(name: String) {
        for listener in listenerSet {
            if listener.name == name {
                listenerSet.remove(listener)
                break
            }
        }
    }
    
    func removeAllListeners() {
        listenerSet.removeAll(keepCapacity: false)
    }
    
    init(_ v: T, setterAction action: SetterAction) {
        value = v
        setterAction = action
    }
}

// MARK: -
class BDUserDefaults {
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    //    static var isLogined: Bool {
    //        if let _ = BDUserDefaults. {
    //            <#code#>
    //        }
    //    }
    
    static var userID: Listenable<String?> = {
        let userID = defaults.stringForKey(userIDKey)
        
        return Listenable<String?>(userID) { userID in
            defaults.setObject(userID, forKey: userIDKey)
        }
    }()
    
    static var username: Listenable<String?> = {
        let username = defaults.stringForKey(usernameKey)
        
        return Listenable<String?>(username) { username in
            defaults.setObject(username, forKey: usernameKey)
        }
    }()
    
}

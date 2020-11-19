//
//  Intents.swift
//  Procedure
//
//  Created by Grady Zhuo on 2017/9/2.
//  Copyright © 2017年 Grady Zhuo. All rights reserved.
//

import Foundation

public struct Intents {
    public typealias IntentType = Intent
    internal var storage: [String: IntentType] = [:]
    
    public var commands: [String] {
        return storage.keys.map{ $0 }
    }
    
    public var count:Int{
        return storage.count
    }
    
    public mutating func add(intent: IntentType?){
        
        guard let intent = intent else{
            Utils.Log(debug: "An intent to add into intents(\(withUnsafePointer(to: &self, { $0 }))) is nil.")
            return
        }
        storage[intent.command] = intent
    }
    
    public mutating func add(intents: [IntentType]){
        for intent in intents {
            self.add(intent: intent)
        }
    }
    
    public mutating func add(intents: Intents){
        for (_, intent) in intents.storage{
            self.add(intent: intent)
        }
    }
    
    public mutating func remove(for name: String)->IntentType!{
        return storage.removeValue(forKey: name)
    }
    
    public mutating func remove(intent: IntentType){
        storage.removeValue(forKey: intent.command)
    }
    
    public func contains(command: String)->Bool {
        return commands.contains(command)
    }
    
    public func contains(intent: SimpleIntent)->Bool {
        return commands.contains(intent.command)
    }
    
    public func intent(for name: String)-> IntentType! {
        return storage[name]
    }
    
    //MARK: - init
    
    public static var empty: Intents {
        return []
    }
    
    public init(array intents: [IntentType]){
        self.add(intents: intents)
    }
    
    public init(intents: Intents){
        self.add(intents: intents)
    }
    
    //MARK: - subscript
    
    public subscript(name: String)->IntentType!{
        
        set{
            guard let intent = newValue else {
                return
            }
            
            self.add(intent: intent)
        }
        
        get{
            return intent(for: name)
        }
        
    }
}

extension Intents : ExpressibleByArrayLiteral{
    public typealias Element = IntentType
    
    
    public init(arrayLiteral elements: Element...) {
        self = Intents(array: elements)
    }
    
}

extension Intents : ExpressibleByDictionaryLiteral{
    public typealias Key = String
    public typealias Value = Any
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            let intent = SimpleIntent(command: key, value: value)
            self.add(intent: intent)
        }
    }
    
}

public func +(lhs: Intents, rhs: Intents)->Intents{
    var gifts = lhs
    gifts.add(intents: rhs)
    return gifts
}

public func +(lhs: Intents, rhs: Intents.IntentType)->Intents{
    var intents = lhs
    intents.add(intent: rhs)
    return intents
}

public func +(lhs: Intents, rhs: String)->Intents{
    var intents = lhs
    intents.add(intent: SimpleIntent(command: rhs))
    return intents
}

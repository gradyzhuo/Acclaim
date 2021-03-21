//
//  Protocols.swift
//  Procedure
//
//  Created by Grady Zhuo on 18/12/2016.
//  Copyright © 2016 Grady Zhuo. All rights reserved.
//

import Foundation

//MARK: - Protocols of Intent


internal let __ExpressibleByNilLiteral__ = "__ExpressibleByNilLiteral__"
public protocol Intent : ExpressibleByNilLiteral {
    var command: String { get }
    var value: Any? { get }
    
    init(command: String, value: Any?)
}

extension Intent {

    public init(nilLiteral: ()){
        self = Self.init(command: __ExpressibleByNilLiteral__, value: nil)
    }

}

//MARK: - Protocols of Step

public protocol Identitiable {
    var identifier: String { get }
}

public protocol Flowable {
    /**
     (readonly)
     */
    var previous: Step? { set get }
    var next: Step? { set get }
    
    var last:Step { get }
    
    mutating func `continue`<T: Step>(with step:T, asLast: Bool, copy:Bool)->T where T:Copyable
}


public protocol Step : Flowable {
    
    var name: String { set get }
    
    func run(with intents: Intents)
}

extension Step {
    
    public var last:Step{
        var nextStep: Step = self

        while let next = nextStep.next {
            nextStep = next
        }
        return nextStep
    }
    
    /**
     設定接續的step，預設會串連在 last step 後面.
     - parameters:
         - with: the next step
         - asLast: to be a next step after last step
     */
    @discardableResult
    public func `continue`<T>(with step:T, asLast: Bool = true, copy: Bool = false)->T where T : Step , T:Copyable{
        var step = step
        if copy{
            step = step.copy
        }
        var last = asLast ? self.last : self
        last.next = step
        return step
    }

}

public protocol Copyable : class, NSCopying{ }

extension Copyable {
    
    public var copy: Self {
        return self.copy(with: nil) as! Self
    }
    
}

//MARK: - protocol Invocable
public protocol Invocable {
    var tasks: [Task] { get }
    
    init(tasks: [Task])
    
    mutating func invoke(tasks: [Task])
}

//MARK: - protocol Propagatable

public protocol Propagatable : Step, Invocable{
    func run(with intents: Intents, direction: Task.PropagationDirection)
}

//MARK: - Shareable

//let k = UnsafeMutableRawPointer.allocate(byteCount: 0, alignment: 0)
//public protocol Shareable : Copyable, Identitiable{
//
//}

//private var instances:[String:Shareable] = [:]
//
//extension Shareable {
//
//    public static func shared(forKey key: String)->Self?{
//        return instances[key]?.copy
//    }
//
//    public func share()->String{
//        self.share(forKey: identifier)
//        return identifier
//    }
//
//    public func share(forKey key:String){
//        Self.instances[key] = copy
//    }
//}

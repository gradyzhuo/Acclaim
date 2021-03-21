//
//  Action.swift
//  Procedure
//
//  Created by Grady Zhuo on 22/11/2016.
//  Copyright © 2016 Grady Zhuo. All rights reserved.
//

import Foundation

public typealias InputIntents = Intents

extension Task {
    
    public enum PropagationDirection : Int{
        case forward
        case backward
    }
    
    //MARK: typealias defines
    public enum Result {
        case succeedWith(outcome: Intent?)
        case failureWith(error: Procedure.Error?)

        public var outcomes: Intents {

            var o: Intent?
            switch self {
            case .succeedWith(let outcome):
                o = outcome
            case .failureWith(let error):
                o = error
            }

            guard let outcome = o else {
                return []
            }

            return [outcome]
        }

        public static var succeed: Result {
            return .succeedWith(outcome: nil)
        }

        public static var failure: Result {
            return .failureWith(error: Procedure.Error(name: "Error", reason: "Unknown reason", userInfo: nil))
        }

    }
}

open class Task : Identitiable, Hashable, CustomStringConvertible {
    
    public typealias Action = (InputIntents, @escaping (Result)->Void)->Void
    public internal(set) var identifier: String
    public internal(set) var action: Action
    
    public internal(set) var propagationDirection: PropagationDirection = .forward
    
    public var isCancelled:Bool{
        return self.runningItem?.isCancelled ?? false
    }
    
    internal var runningItem: DispatchWorkItem?
    
    public func hash(into hasher: inout Hasher) {
        self.identifier.hash(into: &hasher)
    }
    
    public init(identifier:String = Utils.Generator.identifier(), propagationDirection direction: PropagationDirection = .forward, do action: @escaping Action){
        self.identifier = identifier
        self.action = action
        self.propagationDirection = direction
    }
    
    public func run(with inputs: InputIntents, inQueue queue: DispatchQueue = .main, completion:((Task, Intents)->Void)? = nil){
        
        let taskClosure = self.action
        let task = self

        let workItem = DispatchWorkItem {
            taskClosure(inputs){ result in
                //Waitting for the completion handler be called.
                var intents = Intents.empty
                intents.add(intents: result.outcomes)
                completion?(task, intents)
            }
        }
        
        queue.async(execute: workItem)
        self.runningItem = workItem
        
    }
    
    
    public func cancel(){
        guard let runningItem = runningItem else {
            return
        }
        
        if !runningItem.isCancelled {
            runningItem.cancel()
        }
        
    }
    
    public var description: String{
        return "Task(\(identifier)): \(String(describing: action))"
    }
    
    deinit {
        print("deinit action : \(identifier)")
    }
}

public func ==(lhs: Task, rhs: Task)->Bool{
    return lhs.identifier == rhs.identifier
}

extension Task : Copyable {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let taskCopy = self.action
        return Task(identifier: identifier, do: taskCopy)
    }
    
    
}

//
//  Step.swift
//  Procedure
//
//  Created by Grady Zhuo on 22/11/2016.
//  Copyright © 2016 Grady Zhuo. All rights reserved.
//

import Foundation

public typealias OutputIntents = Intents
open class SimpleStep : Step, Propagatable, Flowable, Shareable, CustomStringConvertible {

    public typealias IntentType = SimpleIntent
    
    public var identifier: String{
        return queue.label
    }
    public lazy var name: String = self.identifier
    
    public internal(set) var tasks: [Task] = []
    
    public var next: Step?{
        didSet{
            let current = self
            next.map{ nextStep in
                var nextStep = nextStep
                nextStep.previous = current
            }
        }
    }
    
    internal let autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency
    internal let attributes: DispatchQueue.Attributes
    internal let qos: DispatchQoS
    public var queue: DispatchQueue
    
    internal var flowHandler:(OutputIntents)->FlowControl = { _ in
        return .next
    }
    
    public convenience init(direction: Task.PropagationDirection = .forward, do action: @escaping Task.Action){
        let newTask = Task(propagationDirection: direction, do: action)
        self.init(task: newTask)
    }
    
    internal init(tasks:[Task] = [], attributes: DispatchQueue.Attributes = .concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit, qos: DispatchQoS = .userInteractive, other: SimpleStep? = nil){
        self.autoreleaseFrequency = autoreleaseFrequency
        self.attributes = attributes
        self.qos = qos
        
        self.queue = DispatchQueue(label: Utils.Generator.identifier(), qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: other?.queue)
        
        self.invoke(tasks: tasks)
        
    }
    
    public convenience init(task: Task) {
        self.init(tasks: [task])
    }
    
    public required convenience init(tasks: [Task] = []) {
        self.init(tasks: tasks, attributes: .concurrent, autoreleaseFrequency: .inherit, qos: .userInteractive, other: nil)
    }
    
    
    public func invoke(tasks: [Task]) {
        for task in tasks {
            invoke(task: task)
        }
    }
    
    public func setControl(_ flowControl: @escaping (OutputIntents)->FlowControl){
        flowHandler = flowControl
    }
    
    public func run(with inputs: Intent...){
        self.run(with: Intents(array: inputs))
    }
    
    public func run(with inputs: Intents = []){
        self.run(with: inputs, direction: .forward)
    }

    public func run(with inputs: Intents, direction: Task.PropagationDirection){
        let privateRunfunction = self._run
        DispatchQueue.main.async {
            privateRunfunction(inputs, direction)
        }
    }
    
    public func cancel(){
        for act in tasks {
            act.cancel()
        }
    }
    
    internal func _run(with inputs: Intents, direction: Task.PropagationDirection){
        let queue = self.queue
        let group = DispatchGroup()
        
        var outputs: Intents = []
        
        self.tasks.filter{ $0.propagationDirection == direction }.forEach{ task in
            group.enter()
            task.run(with: inputs, inQueue: queue){ action, intents in
                outputs.add(intents: intents)
                
                group.leave()
            }
        }
        let current = self
        group.notify(queue: DispatchQueue.main){
            current.actionsDidFinish(original: inputs, outputs: outputs)
        }
        
    }
    
    internal func actionsDidFinish(original inputs: Intents, outputs: Intents){
        
        let outputs = inputs + outputs
        
        let control = flowHandler(outputs)
        switch control {
        case .repeat:
            run(with: outputs)
        case .cancel:
            print("cancelled")
        case .finish:
            print("finished")
        case .nextWith(let filter):
            goNext(with: filter(outputs))
        case .previousWith(let filter):
            goBack(with: filter(outputs))
        case .jumpTo(let other, let filter):
            jump(to: other, with: filter(outputs))
        }
        
    }
    
    
    public func goNext(with intents: Intents){
        if let next = next as? Propagatable {
            next.run(with: intents, direction: .forward)
        }else{
            next?.run(with: intents)
        }
        
    }
    
    public func goBack(with intents: Intents){
        
        if let previous = previous as? Propagatable {
            previous.run(with: intents, direction: .backward)
        }else{
            previous?.run(with: intents)
        }
    }
    
    public func jump(to step: Step, with intents: Intents){
        if let step = step as? Propagatable {
            step.run(with: intents, direction: .forward)
        }else{
            step.run(with: intents)
        }
    }
    
    public var description: String{
        
        let actionDescriptions = tasks.reduce("") { (result, action) -> String in
            return result.count == 0 ? "<\(action)>" : "\(result)\n<\(action)>"
        }
        
        return "\(type(of: self))(\(identifier)): [\(actionDescriptions)]"
    }
    
    deinit {
        print("deinit Step : \(identifier)")
    }
}

extension SimpleStep : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        identifier.hash(into: &hasher)
    }
}

public func ==<T:Hashable>(lhs: T, rhs: T)->Bool{
    return lhs.hashValue == rhs.hashValue
}

extension SimpleStep : Copyable{
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let tasksCopy = self.tasks.map{ $0.copy }
        let aCopy = SimpleStep(attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, qos: qos)
        aCopy.invoke(tasks: tasksCopy)
        aCopy.flowHandler = flowHandler
        return aCopy
    }
}

extension SimpleStep {
    public func invoke(task: Task){
        tasks.append(task)
    }
    
    public func invoke(direction: Task.PropagationDirection = .forward, do action: @escaping Task.Action)->Task{
        let newTask = Task(propagationDirection: direction, do: action)
        self.invoke(task: newTask)
        return newTask
    }
    
    public func remove(tasks: [Task]){
        for task in tasks {
            self.remove(task: task)
        }
    }
    
    public func remove(task: Task){
        tasks = tasks.filter {
            return $0 != task
        }
    }
}


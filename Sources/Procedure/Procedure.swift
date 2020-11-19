public enum FlowControl {
    case `repeat`
    case nextWith(filter: (Intents)->Intents)
    case previousWith(filter: (Intents)->Intents)
    case cancel
    case finish
    case jumpTo(other: Step, filter: (Intents)->Intents)
    
    public static var next: FlowControl {
        return .nextWith(filter: { $0 })
    }
    
    public static var previous: FlowControl{
        return .previousWith(filter: { $0 })
    }
    
    public static func jump(other: Step)->FlowControl{
        return .jumpTo(other: other, filter: { $0 })
    }
}


open class Procedure : Step, Flowable{
    public private(set) var start: Step
    public private(set) var end: Step
    
    public var next: Step?{
        set{
            end.next = newValue
        }
        get{
            return end.next
        }
    }
    
    public func run(with intents: Intents = []) {
        start.run(with: intents)
    }
    
    public lazy var name: String = self.identifier
    
    public init(start: Step) {
        self.start = start
        self.end = start.last
    }
    
    public func step(at index: Int)->Step?{
        var target: Step? = start
        for _ in 0...index{
            target = target?.next
        }
        return target
    }
    
    public func extend(with newLastStep: Step){
        end.next = newLastStep
        end = newLastStep.last
    }
    
    public func syncEndStep(){
        end = start.last
    }
}


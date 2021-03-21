import Foundation
import ShellHelper

public protocol LoggingType: LoggingActionable, TextOutputStreamable{
    var streamer: WritableStreamer { get }
    
    var level:LoggingLevel { get }
    
    init(level: LoggingLevel, namespace: String, streamer: WritableStreamer)
}

public protocol LoggingActionable{
    func log(_ items: [Any], prefix:String?, separator: String, end: String)
}

extension LoggingType{
    
    public init(level: LoggingLevel, namespace: String = "ROOT", streamer: WritableStreamer = ConsoleOutputStream.stdout) {
        self.init(level: level, namespace: namespace, streamer: streamer)
    }
    
    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target = self.streamer as! Target
    }
}

extension LoggingActionable where Self: LoggingType{
    public func log(_ items: Any..., prefix:String? = nil, separator: String = " ", end: String = "\n"){
        self.log(items, separator: separator, end: end)
    }
    
    public func log(_ items: [Any], prefix:String? = nil, separator: String = " ", end: String = "\n") {
        var strings = items.map{ String(describing: $0)}
        if let prefix = prefix {
            strings = [prefix] + strings
        }
        let result = strings.joined(separator: separator) + end
        self.streamer.writeAndFlush(result)
    }
}

public struct LoggingManager<Logging: LoggingType>{
    public internal(set) var current: Logging
    
    public var textColor: TextColor
    public var backgroundColor: BackgroundColor
    public var textStyles: [TextStyle]
    
    public var prefix: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        
        let prefixText = "[\(formatter.string(from: Date()))] \(self.current.level.name):"
        
        guard Logger.rootConfig.colored else {
            return prefixText
        }
        
        var effected = prefixText.effect()
        effected.textColor = self.textColor
        effected.backgroundColor = self.backgroundColor
        effected.styles = self.textStyles
        return effected.formatted
    }
    
    public init(level: LoggingLevel, textColor: TextColor, backgroundColor: BackgroundColor = .default, textStyles: [TextStyle] = []){
        self.current = Logging.init(level: level)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textStyles = textStyles
    }
}

extension LoggingManager: LoggingActionable{
    public func log(_ items: [Any], prefix: String? = nil, separator: String = " ", end: String = "\n") {
        self.current.log(items, prefix: prefix, separator: separator, end: end)
    }
}

extension LoggingManager{
    
    public func callAsFunction(_ items: Any...){
        self.log(items, prefix: prefix)
    }
    
    public subscript(namespace namespace: String)->Self{
        var copied = self
        copied.current = Logging(level:self.current.level, namespace: namespace, streamer: self.current.streamer)
        return copied
    }
}



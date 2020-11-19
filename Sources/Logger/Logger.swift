import Foundation
import ShellHelper

public class StdLog{
    public enum Level{
        case info
        case debug
        case warn
        case error
    }
    
    var level:Level
    
    public init(level:Level) {
        self.level = level
    }
    
    public func callAsFunction(_ test: String...){
        
        print(type(of: test))
    }
}


//
//  File.swift
//  
//
//  Created by Grady Zhuo on 2021/2/27.
//

import Foundation

public struct Logger{
    public internal(set) static var critical = LoggingManager<StderrLogging>(level: .critical, textColor: .red, backgroundColor: .white)
    public internal(set) static var error    = LoggingManager<StderrLogging>(level: .error, textColor: .red)
    public internal(set) static var warnning = LoggingManager<StderrLogging>(level: .warnning, textColor: .yellow)
    public internal(set) static var info     = LoggingManager<StdoutLogging>(level: .info, textColor: .cyan)
    public internal(set) static var debug    = LoggingManager<StdoutLogging>(level: .debug, textColor: .green)
    public internal(set) static var trace    = LoggingManager<StdoutLogging>(level: .trace, textColor: .default)
    
    public internal(set) static var fatal    = critical
    public internal(set) static var warn     = warnning
    
}

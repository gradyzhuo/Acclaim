//
//  File.swift
//  
//
//  Created by Grady Zhuo on 2021/2/27.
//
import ShellHelper

public enum LoggingLevel: Int{
    case critical = 50
    case error    = 40
    case warnning = 30
    case info     = 20
    case debug    = 10
    case trace    =  5
    
    public static var fatal: Self { .critical }
    public static var warn : Self { .warnning }
    
    public var name: String{
        switch self {
        case .critical:
            return "CRITICAL"
        case .error:
            return "ERROR"
        case .warnning:
            return "WARNNING"
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        case .trace:
            return "TRACE"
        }
    }
}

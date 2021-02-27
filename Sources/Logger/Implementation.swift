//
//  File.swift
//  
//
//  Created by Grady Zhuo on 2021/2/27.
//

import Foundation

/*
 CRITICAL = 50
 FATAL = CRITICAL
 ERROR = 40
 WARNING = 30
 WARN = WARNING
 INFO = 20
 DEBUG = 10
 TRACE = 5
 NOTSET = 0
 */
public struct StdoutLogging: LoggingType{
    public internal(set) var level:LoggingLevel
    public internal(set) var namespace: String
    public internal(set) var streamer: WritableStreamer
    
    public init(level: LoggingLevel, namespace: String, streamer: WritableStreamer = ConsoleOutputStream.stdout) {
        self.level = level
        self.streamer = streamer
        self.namespace = namespace
    }
}

public struct StderrLogging: LoggingType{
    public internal(set) var level:LoggingLevel
    public internal(set) var namespace: String
    public internal(set) var streamer: WritableStreamer
    
    public init(level: LoggingLevel, namespace: String, streamer: WritableStreamer = ConsoleOutputStream.stderr) {
        self.level = level
        self.streamer = streamer
        self.namespace = namespace
    }
}

//public struct StdLogging: LoggingType{
//    public var level:LoggingLevel{ .debug }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}

//public struct Critical: LoggingType{
//    public static var level:LoggingLevel{ .critical }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//public struct Fatal: LoggingType{
//    public static var level:LoggingLevel{ .fatal }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//public struct Error: LoggingType{
//    public static var level:LoggingLevel{ .error }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//public struct Warnning: LoggingType{
//    public static var level:LoggingLevel{ .warnning }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//public struct Warn: LoggingType{
//    public static var level:LoggingLevel{ .warn }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//
//public struct Info: LoggingType{
//    public static var level:LoggingLevel{ .info }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//public struct Debug: LoggingType{
//    public static var level:LoggingLevel{ .debug }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//
//public struct Trace: LoggingType{
//    public static var level:LoggingLevel{ .trace }
//
//    public internal(set) var namespace: String
//    public internal(set) var steamer: LoggingStreamer
//
//    public init(namespace: String, steamer: LoggingStreamer) {
//        self.steamer = steamer
//        self.namespace = namespace
//    }
//}
//

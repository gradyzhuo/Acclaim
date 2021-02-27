//
//  File.swift
//  
//
//  Created by Grady Zhuo on 2021/2/27.
//

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Darwin
let systemStderr = Darwin.stderr
let systemStdout = Darwin.stdout
#elseif os(Windows)
import MSVCRT
let systemStderr = MSVCRT.stderr
let systemStdout = MSVCRT.stdout
#else
import Glibc
let systemStderr = Glibc.stderr!
let systemStdout = Glibc.stdout!
#endif

public protocol WritableStreamer: TextOutputStream{
    func flush()
    func writeAndFlush(_ string: String)
}

public struct ConsoleOutputStream: WritableStreamer{
    internal let filePointer: UnsafeMutablePointer<FILE>
    
    public func write(_ string: String) {
        string.withCString { ptr in
            #if os(Windows)
            _lock_file(self.filePointer)
            #else
            flockfile(self.filePointer)
            #endif
            
            defer {
                #if os(Windows)
                _unlock_file(self.filePointer)
                #else
                funlockfile(self.filePointer)
                #endif
            }
            fputs(ptr, self.filePointer)
        }
    }
    
    public func flush(){
        fflush(self.filePointer)
    }
    
    public func writeAndFlush(_ string: String){
        self.write(string)
        self.flush()
    }
    
    
    public static let stderr = Self.init(filePointer: systemStderr)
    public static let stdout = Self.init(filePointer: systemStdout)
}

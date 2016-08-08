//
//  Debug.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 08/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation

public class Debug {
    static let shouldDebugLog = true
    static let shouldDebugThrow = true
    
    public class func Log(_ title:String , info:Any) {
        if shouldDebugLog {
            print("👁 Log: \(title) --")
            print(info)
            print("-----------------------------------")
        }
    }
    
    public class func Throw(_ info: String, error: ErrorProtocol) -> ErrorProtocol {
        if shouldDebugThrow {
            print("⚠️ Exception: \(error) --")
            print(info)
            print("-----------------------------------")
        }
        return error
    }
}

//
//  BridgeComm.swift
//  BridgeSDK
//
//  Created by Mon Zacharias on 12/10/2024.
//

import Foundation

@objc
public class BridgeComm: NSObject {
    
    var commData: String
    
    @objc
    required public override init() {
        self.commData = ""
    }
    
    @objc(send:)
    public func send(data: String) {
        self.commData = data
        print("=== \(type(of: self)).\(#function):\(#line) - \(data)")
    }
    
    @objc
    public func receive() -> String {
        print("=== \(type(of: self)).\(#function):\(#line) - \(commData)")
        let today = Date.now
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return "=== \(type(of: self)).\(#function):\(#line) " + self.commData + ":::" + formatter.string(from: today)
    }
}

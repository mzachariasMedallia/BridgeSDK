//
//  BridgeSDK.swift
//  BridgingSDK
//
//

import Foundation
@objc
public class BridgeSDK: NSObject {
    
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

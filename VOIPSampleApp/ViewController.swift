//
//  ViewController.swift
//  VOIPSampleApp
//
//  Created by Toor, Sanju on 21/08/18.
//  Copyright © 2018 Toor, Sanju. All rights reserved.
// PKPushRegistryDelegate

import UIKit
import CallKit
import PushKit

class ViewController: UIViewController, CXProviderDelegate, PKPushRegistryDelegate {
    
//    // Incoming call code
//        override func viewDidLoad() {
//            let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
//            provider.setDelegate(self, queue: nil)
//            let update = CXCallUpdate()
//            update.remoteHandle = CXHandle(type: .generic, value: "Pete Za")
//            provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
//        }
    
    // send a call
//    override func viewDidLoad() {
//        let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
//        provider.setDelegate(self, queue: nil)
//        let controller = CXCallController()
//        let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "Pete Za")))
//        controller.request(transaction, completion: { error in })
//    }

    // connect a call
//    override func viewDidLoad() {
//        let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
//        provider.setDelegate(self, queue: nil)
//        let controller = CXCallController()
//        let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "Pete Za")))
//        controller.request(transaction, completion: { error in })
//
//        DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 5) {
//            provider.reportOutgoingCall(with: controller.callObserver.calls[0].uuid, connectedAt: nil)
//        }
//    }
    
        override func viewDidLoad() {
            let registry = PKPushRegistry(queue: DispatchQueue.main)
            registry.delegate = self
            registry.desiredPushTypes = [PKPushType.voIP]
        }
        
        func providerDidReset(_ provider: CXProvider) {
        }
    
        func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
            action.fulfill()
        }
    
        func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
            action.fulfill()
        }
    
        func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
            NSLog("voip token: \(pushCredentials.token)")
            print(pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined())
        }
        
        func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
            let config = CXProviderConfiguration(localizedName: "My App")
            config.iconTemplateImageData = UIImagePNGRepresentation(UIImage(named: "pizza")!)
            config.ringtoneSound = "ringtone.caf"
            config.includesCallsInRecents = false;
            config.supportsVideo = true;
            let provider = CXProvider(configuration: config)
            provider.setDelegate(self, queue: nil)
            let update = CXCallUpdate()
            update.remoteHandle = CXHandle(type: .generic, value: "Pete Za")
            update.hasVideo = true
            provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
        }
}


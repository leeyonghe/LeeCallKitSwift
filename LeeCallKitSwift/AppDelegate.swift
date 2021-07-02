//
//  AppDelegate.swift
//  LeeCallKitSwift
//
//  Created by ios-dev on 2021/07/01.
//

import UIKit
import CallKit
import PushKit
import UserNotifications
import UserNotificationsUI
@main
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate, UNUserNotificationCenterDelegate, CXProviderDelegate {
    
    var provider : CXProvider?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        voipRegistration()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func voipRegistration() -> Void {
        
        let voipRegistry = PKPushRegistry.init(queue: DispatchQueue.main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        
        let configuration = CXProviderConfiguration.init()
        configuration.includesCallsInRecents = true
        configuration.supportsVideo = true;
        configuration.supportedHandleTypes = [.phoneNumber]
        configuration.maximumCallGroups = 1;
        configuration.maximumCallsPerCallGroup = 5;
        
        provider = CXProvider.init(configuration: configuration)
        provider?.setDelegate(self, queue: DispatchQueue.main)
        
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        
    }
    
    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        CallView()
    }
    
    func CallView(){
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .phoneNumber, value: "Call")
        update.hasVideo = true
        provider?.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
    }

}

//
//  ViewController.swift
//  LeeCallKitSwift
//
//  Created by ios-dev on 2021/07/01.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestPushNotificationPermissions()
    }

    func requestPushNotificationPermissions(){
        
        let options: UNAuthorizationOptions = [.alert, .sound];
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
          if settings.authorizationStatus != .authorized {
            
            center.requestAuthorization(options: options) {
              (granted, error) in
                if !granted {
                  print("Something went wrong")
                }else{
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
            
          }
            
        }
        
    }

}


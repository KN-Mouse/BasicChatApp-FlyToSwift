//
//  AppDelegate.swift
//  Fly To
//
//  Created by Nguyen Khang on 16/10/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        FirebaseApp.configure()
        
        return true
    }
}

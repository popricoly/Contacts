//
//  AppDelegate.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if UserDefaults.standard.runFirstly {
            loadContacts()
            UserDefaults.standard.runFirstly = false
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

    func loadContacts() {
        do {
            if let contactsJsonPath = Bundle.main.url(forResource: "Contacts", withExtension: "json") {
                let data = try Data(contentsOf: contactsJsonPath)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                for contactInDictionary in (json as? [Dictionary<String, String>])! {
                    let firstName = contactInDictionary["firstName"] ?? ""
                    let lastName = contactInDictionary["lastName"] ?? ""
                    let phoneNumber = contactInDictionary["phoneNumber"] ?? ""
                    let streetAddress1 = contactInDictionary["streetAddress1"] ?? ""
                    let streetAddress2 = contactInDictionary["streetAddress2"] ?? ""
                    let city = contactInDictionary["city"] ?? ""
                    let state = contactInDictionary["state"] ?? ""
                    let zipCode = contactInDictionary["zipCode"] ?? ""
                    OMContactsStorage.sharedStorage.saveContactWith(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, StreetAddress1: streetAddress1, StreetAddress2: streetAddress2, city: city, state: state, zipCode: zipCode)
                    
                }
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}


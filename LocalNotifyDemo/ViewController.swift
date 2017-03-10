//
//  ViewController.swift
//  LocalNotifyDemo
//
//  Created by Teewa on 10/03/17.
//  Copyright © 2017 Teewa. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    var isGrantedNotificationAccess:Bool = false
    
    @IBAction func send10SecNotification(_ sender: UIButton) {
        if isGrantedNotificationAccess{
            //add notification code here
            
            //Set the content of the notification
            let content = UNMutableNotificationContent()
            content.title = "Nova Mensagem"
            content.subtitle = "Erick Ribeiro"
            content.body = "Fala chefe!!"
            content.badge = 1
            
            //Set the trigger of the notification -- here a timer.
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5,
                repeats: false)
            
            //Set the request for the notification from the above
            let request = UNNotificationRequest(
                identifier: "10.second.message",
                content: content,
                trigger: trigger
            )
            
            //Add the notification to the currnet notification center
            UNUserNotificationCenter.current().add(
                request, withCompletionHandler: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate =  self
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
        }
        )
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}


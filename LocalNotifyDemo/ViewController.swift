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
    
    @IBAction func sendNotificationWithCategory(_ sender: Any) {
        if isGrantedNotificationAccess {
            let content = UNMutableNotificationContent()
            
            content.title = "Novo Quiz"
            content.subtitle = "Questao 1"
            content.body = "Quanto é 1+1?"
            content.badge = 1
            content.categoryIdentifier = "quizCategory"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: "quiz", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "answerOne":
            print("ERRADO")
        case "answerTwo":
            print("Correta")
        case "clue":
            let alert = UIAlertController(title: "Hint", message: "lalala", preferredStyle: .alert)
            let action = UIAlertAction(title: "Flw", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        default:
            break
        }
    }
}


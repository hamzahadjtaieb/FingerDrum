//
//  ViewController.swift
//  FingerDrum
//
//  Created by Mac on 3/30/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit
import UserNotifications



public class ViewController: UIViewController {
    
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var Username_Field: UITextField!
    
    @IBOutlet weak var Password_Field: UITextField!
    
    var server = "http://localhost:3000"
    var server2 = "http://localhost:3000/users"
    
    static var session:User? = nil
    
    

    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        //NOTIFICATION
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        //STEP2
        let content = UNMutableNotificationContent()
        content.title =  " Hey I'am a Notification! "
        content.body = "Hello Hamza !"
        
        //STEP3
        let date = Date().addingTimeInterval(3)
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        //STEP 4 CREATE THE REQUEST
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //STEP 5 Register the request
        center.add(request) { (error) in
            //Check the error paramaetre
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        
        // Set up video in the background
         setUpVideo()
    }
    
    
    func setUpVideo() {
        
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "musc_home12", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.9)
    }
    
    

    
    
    
    
    
    

    @IBAction func LoginButton(_ sender: Any) {
        
        
            print("*********AJ")
            print(Username_Field.text as String?)
            print("*********AJ")
            
            
            
            //self.ShowLoader(message: "Prepartion des données ...")
//            let sv = UIViewController.displaySpinner(onView: self.view)
        
            let url_service: String = self.server+"/users/"+(Username_Field.text as! String)+"/"+(Password_Field.text as! String)
            print("***********")
            print(url_service)
        
        
            Alamofire.request(url_service, method: .get, parameters: nil , encoding: JSONEncoding.default)
                .validate(statusCode: 200...500)
                .responseJSON { response in
                    
                    
                    switch response.result {
                    case .success( _):
                        if response.result.value != nil{
                            
                            
                            
                            if let UserDic = response.result.value as? [String : Any]{
                                
                                let CurrentUser = User(UserDictionary: UserDic)
                                print("ejjaw behi")
                                
                                // response.result.value! -> tout le user en Json
                                print(response.result.value!)
                                
                                //
                                print(CurrentUser)
                                
                                // Id du user
                                print(CurrentUser.role!)
                                
                                
                                ViewController.session = CurrentUser
//                                UIViewController.removeSpinner(spinner: sv)
                                
                                print("le role du User est :")
                                print(ViewController.session!.role!)
                                
                                
                                
                                self.performSegue(withIdentifier: "loghome", sender: nil)
//                                self.role = String(ViewController.session!.role!)
                                
                                
                                
                                
                                
                            }else{
                                
                                print("hachyaaa")
                                
//                                UIViewController.removeSpinner(spinner: sv)
                                let alert = UIAlertController(title: "Echec de connexion", message: "Username ou mot de pass incorrect" , preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler:  {(alert: UIAlertAction!) in self.dismiss(animated: true, completion: nil)
                                    
                                    
                                    
                                })
                                alert.addAction(action)
                                self.present(alert,animated: true)
                            }
                            
                            
                        }else{
                            print("Eroor parsing !")
                        }
                    case .failure(_):
                        print("Request failed")
                    }
                    
                    
            }////
        
        
        
        

        
        
    }
    
    
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "loghome"
            
        {
            
        let vc = segue.destination as! HomeViewController
        vc.Role_User = String(ViewController.session!.role!)
//        vc.session2 = ViewController.session
            
        }
        
        if segue.identifier == "logprofile"{
            
        }
        
        
    }
    
    
}


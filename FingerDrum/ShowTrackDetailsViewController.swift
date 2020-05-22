//
//  ShowTrackDetailsViewController.swift
//  FingerDrum
//
//  Created by Mac on 5/13/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ShowTrackDetailsViewController: UIViewController {
    
    var server = "http://localhost:3000/users"
    var server2 = "http://localhost:3000/"
    
    var imgname = ""
    
    @IBOutlet weak var LabelUsername: UITextField!
    
    @IBOutlet weak var LabelFirst: UITextField!
    
    @IBOutlet weak var LabelLast: UITextField!
    
    @IBOutlet weak var LabelEmail: UITextField!
    
    @IBOutlet weak var LabelPhone: UITextField!
    
    @IBOutlet weak var LabelCountry: UITextField!
    
    @IBOutlet weak var LabelPassword: UITextField!
    
    @IBOutlet weak var LabelImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelUsername.text  = ViewController.session!.username!
        LabelFirst.text     = ViewController.session!.first_name!
        LabelLast.text      = ViewController.session!.last_name!
        LabelEmail.text     = ViewController.session!.email!
        LabelPhone.text     = String(ViewController.session!.phone!)
        LabelCountry.text   = ViewController.session!.country!
        LabelPassword.text  = ViewController.session!.password!
        
//        var img = LabelImage.image!
//
//        Alamofire.request(server2+"img/"+(ViewController.session!.image!)).responseImage { response in
//            if let image = response.result.value {
//                img = image
//            }
//        }
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnEditTapped(_ sender: Any) {
        
        let url_service: String = self.server
        let client_data = [
            
            
            "username": self.LabelUsername.text as! String,
            "email": self.LabelEmail.text as! String ,
            "password": self.LabelPassword.text as! String ,
            "last_name": self.LabelLast.text as! String ,
            "first_name": self.LabelFirst.text as! String ,
            "role": "1",
            "image": "4.jpg",
            "Phone": self.LabelPhone.text as! String,
            "country": self.LabelCountry.text as! String
        ]
        
        let header = [
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request(url_service , method: HTTPMethod.put, parameters: client_data, encoding: URLEncoding.httpBody, headers: header)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success( _):
                    print("JAWEK NICE2 ")
                    if response.result.value != nil{
                        self.performSegue(withIdentifier: "regProf", sender: self)
                        print(response.result.value!)
                        if let UserDic = response.result.value as? [String : Any]{
                            let CurrentUser = User(UserDictionary: UserDic)
                            ViewController.session = CurrentUser
                            
                            
                            //                                print(ViewController.session!.first_name!)
                            //regHome
                            print("JAWEK NICE ")
                            
                            
                        }
                    }else{
                        print("Eroor parsing !")
                    }
                case .failure(_):
                    print("Request failed")
                }
                
                
        //end Alamo
        }
        
        
    }

    

}

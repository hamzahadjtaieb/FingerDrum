//
//  SignUpViewController.swift
//  FingerDrum
//
//  Created by Mac on 5/13/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    var server = "http://localhost:3000/users"

    
    
    
    
    var server2 = "http://192.168.43.66/utgd/web/index.php/users"
    
    @IBOutlet weak var edt_username: UITextField!
    
    @IBOutlet weak var edt_mail: UITextField!
    
    @IBOutlet weak var edt_nom: UITextField!
    
    @IBOutlet weak var edt_prenom: UITextField!
    
    @IBOutlet weak var edt_skills: UITextField!
    
    @IBOutlet weak var edt_soft: UITextField!
    
    @IBOutlet weak var edt_pass: UITextField!
    
    
    @IBAction func inscription(_ sender: Any) {
        
        if(checkForm()){
            
            let sv = UIViewController.displaySpinner(onView: self.view)
            
            let url_service: String = self.server
            let client_data = [
                "username": edt_username.text as! String,
                "email": edt_mail.text as! String ,
                "password": edt_pass.text as! String ,
                "last_name": edt_nom.text as! String ,
                "first_name": edt_prenom.text as! String ,
                "role": "1",
                "image": "4.jpg",
                "Phone": "52637388",
                "country": edt_soft.text as! String
            ]
            
            
            let header = [
                "Content-Type" : "application/x-www-form-urlencoded"
            ]
            
            
            Alamofire.request(url_service , method: HTTPMethod.post, parameters: client_data, encoding: URLEncoding.httpBody, headers: header)
                .validate(statusCode: 200...500)
                .responseJSON { response in
                    
                    switch response.result {
                        
                    case .success( _):
                        print("JAWEK NICE2 ")
                        if response.result.value != nil{
                            self.performSegue(withIdentifier: "regHome", sender: self)
                            print(response.result.value!)
                            if let UserDic = response.result.value as? [String : Any]{
                                let CurrentUser = User(UserDictionary: UserDic)
                                ViewController.session = CurrentUser
                                
                                UIViewController.removeSpinner(spinner: sv)
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
    
    func checkForm() -> Bool {
        if(edt_username.text?.count == 0 ){
            edt_username.layer.borderColor = UIColor.red.cgColor
            edt_username.layer.borderWidth = 1.0
            return false
        }else if(edt_nom.text?.count == 0 ){
            edt_nom.layer.borderColor = UIColor.red.cgColor
            edt_nom.layer.borderWidth = 1.0
            return false
        }else if(edt_prenom.text?.count == 0 ){
            edt_prenom.layer.borderColor = UIColor.red.cgColor
            edt_prenom.layer.borderWidth = 1.0
            return false
        }else if(edt_mail.text?.count == 0 ){
            edt_mail.layer.borderColor = UIColor.red.cgColor
            edt_mail.layer.borderWidth = 1.0
            return false
        }else if(edt_soft.text?.count == 0 ){
            edt_soft.layer.borderColor = UIColor.red.cgColor
            edt_soft.layer.borderWidth = 1.0
            return false
        }else if(edt_skills.text?.count == 0 ){
            edt_skills.layer.borderColor = UIColor.red.cgColor
            edt_skills.layer.borderWidth = 1.0
            return false
        }else if(edt_pass.text?.count == 0 ){
            edt_pass.layer.borderColor = UIColor.red.cgColor
            edt_pass.layer.borderWidth = 1.0
            return false
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

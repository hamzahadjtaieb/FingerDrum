//
//  CommentaireViewController.swift
//  FingerDrum
//
//  Created by Mac on 4/3/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class CommentaireViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var tab: UITableView!
    
//    ,UITableViewDataSource,UITableViewDelegate 
    
    var server_image = "http://localhost:3000/img/"
    var server_like = "http://localhost:3000/likes/"
    var server_likes = "http://localhost:3000/likess/"
    
    var server_cmnt = "http://localhost:3000/commentaire/"
//    ?id=
    
    
    //GHALtin edhouma
    var server_cmnt_fetch = "http://192.168.43.66/utgd/web/index.php/comment/workcmnt"
    var server_service_check = "http://192.168.43.66/utgd/web/index.php/worklikes/checklike"
    
    @IBOutlet weak var btn_aimer: UIButton!
    @IBOutlet weak var edt_comment: UITextField!
    
    
    @IBOutlet weak var txt_nbr_cmnt: UILabel!
    @IBOutlet weak var txt_nbr_like: UILabel!
    
    static var track:Track? = nil
    var cmntList = [Comment]()
    var Tracklist = [Track]()

    
    @IBOutlet weak var Image_CommView: UIImageView!
    
    @IBOutlet weak var Title_Label_CommView: UILabel!
    
    let button: UIButton = {
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        return button
    }()
    
    let Share = "This Track is Awesome ! "+CommentaireViewController.track!.title!+" 🔥"
    
    
    @IBAction func onSharetapped(_ sender: Any) {
        
        
        guard let image = UIImage(named: "img12") else {return}
        
        let activityController = UIActivityViewController(activityItems: [Share,image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    // LIKE -
    @IBAction func doLike(_ sender: Any) {
        
        btn_aimer.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        
        let url_service: String = self.server_like
        let client_data = [
            "id_user": String(ViewController.session!.id!) ,
            "id_track": String(CommentaireViewController.track!.id!)
        ]
        
        let header = [
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
        
        
        //ALAMOFIRE LIKE
        Alamofire.request(url_service , method: HTTPMethod.post, parameters: client_data, encoding: URLEncoding.httpBody, headers: header)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success( _):
                    if response.result.value != nil
                    {
//                        print(response.result.value!)
                        self.btn_aimer.isUserInteractionEnabled = false
                        self.btn_aimer.setTitle("Already Liked", for: .normal)
                        self.btn_aimer.setTitleColor(UIColor.gray, for: .normal)
                        
                        print("salem Like")
                        
                        
                        
                        
                        
                        
                    }else{
                        print("Eroor parsing !")
                    }
                case .failure(_):
                    print("Request failed")
                    
                    self.txt_nbr_like.text = String(CommentaireViewController.track!.nbr_like! + 1)
                    
//                    print(response.result.value)

//                    self.btn_aimer.isUserInteractionEnabled = false
//                    self.btn_aimer.addTarget(self, action: #selector(self.handleShowPopUp), for: .touchUpInside)
//                    self.btn_aimer.setTitle("Already Liked", for: .normal)
//                    self.btn_aimer.setTitleColor(UIColor.gray, for: .normal)
//                    print("salem Like")
                }
                
                
        }
        
    }
    
    
    //id_work walla id_track
    
    // - COMMENTAIRE
    @IBAction func doComment(_ sender: Any) {
        
        
//var server_cmnt = "http://localhost:3000/commentaire/"
        
        
        if((edt_comment.text?.count)! > 0 ){
            
            //let sv = UIViewController.displaySpinner(onView: self.view)
            let url_service: String = self.server_cmnt
            let client_data = [
                "id_user": String(ViewController.session!.id!),
                "id_track": String(CommentaireViewController.track!.id!),
                "content": edt_comment.text as! String,
                "username": String(ViewController.session!.username!),
            ]
            
            let header = [
                "Content-Type" : "application/x-www-form-urlencoded"
            ]
            
            Alamofire.request(url_service , method: HTTPMethod.post, parameters: client_data, encoding: URLEncoding.httpBody, headers: header)
                .validate(statusCode: 200...500)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success( _):
                        if response.result.value != nil{
                            print(response.result.value!)
                            if let CmntDic = response.result.value as? [String : Any]{
                                
                                let comment = Comment(CommentDictionary: CmntDic)
                                self.cmntList.insert(comment, at: 0)
                                self.tab.reloadData()
                                // UIViewController.removeSpinner(spinner: sv)
                                self.edt_comment.text = ""
                                print("Le Commentaire Entre est • ",comment.content!)
                                
                                
                            }
                        }else{
                            print("Eroor parsing !")
                        }
                    case .failure(_):
                        print("Request failed")
                        
                            
                    }
                    
                    
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
    //TABLE VIEW COMMENTAIRE
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cmntList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemComnt")
        
        let lb_user = cell!.viewWithTag(2) as! UILabel
        let lb_content = cell!.viewWithTag(3) as! UITextView
        _ = cell!.viewWithTag(1) as! UIImageView
        
        lb_user.text = cmntList[indexPath.row].username
        lb_content.text = cmntList[indexPath.row].content
    
        
    
        
        
        //Will Try with a cell
        
        
        
        return cell!
    }
    
    
    
    override public func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        fetchData ()
        
        Alamofire.request(server_image+CommentaireViewController.track!.image!).responseImage { response in
            if let image = response.result.value {
                self.Image_CommView.image = image
            }
        }
        
        Title_Label_CommView.text = CommentaireViewController.track!.title
        
        print("CommentaireViewController • Image name : "+CommentaireViewController.track!.image!)
        print("CommentaireViewController • Title name : "+CommentaireViewController.track!.title!)
        
        
    }
    
    
    
    
    /// POPUP
    
    var success = true
    
    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(popUpWindow)
        
        //ALAMOFIRE IMAGE
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        visualEffectView.alpha = 0 
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleShowPopUp(){
        
        print("show pop up window..")
        
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
        
    }
    
    

    
    
    
    
    //FETCH DATA
    
    func  fetchData () {
        
        
        print("fetch comments workId or TrackId : "+String(CommentaireViewController.track!.id!))
        
        
        _ = [
            "id": String(ViewController.session!.id!)
        ]
        
        
//        VA VOIR LE SERVER • var server_cmnt_fetch = "http://192.168.43.66/utgd/web/index.php/comment/workcmnt"
//        let service = server_cmnt_fetch+"?id="+String(CommentaireViewController.track!.id!)
//        server_cmnt
        
        //hedhi elli badaltha
//        let service = server_cmnt_fetch+"/"+String(CommentaireViewController.track!.id!)
        
        //server_cmnt
//        let service = server_cmnt+"/"+String(CommentaireViewController.track!.id!)
        let service = server_cmnt+String(CommentaireViewController.track!.id!)
        
        
        //VA VOIR LE SERVER AUSSI • var server_service_check = "http://192.168.43.66/utgd/web/index.php/worklikes/checklike"
        
        
//       SERVER 2 elli badaltou LIKEZZ
//       let url_service_check = server_service_check+"?id="+String(ViewController.session!.id!)+"&id_track="+String(CommentaireViewController.track!.id!)
//         let url_service_check = server_like+"/"+String(ViewController.session!.id!)+"/"+String(CommentaireViewController.track!.id!)
        let url_service_check = server_likes+String(ViewController.session!.id!)+"/"+String(CommentaireViewController.track!.id!)
        
        
        
        
        print("COMMENTAIRE LIST : ")
        print(cmntList.count)
        
        self.cmntList.removeAll()
        print("COMMENTAIRE LIST : AFTER  ")
        print(cmntList)
        
        //ALAMOFIRE
        Alamofire.request(service, method: .get, parameters: nil , encoding: JSONEncoding.default)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                case .success( _):
                    
                    print("*** COMMENT • response.result.value! DOWN : ")
                    print(response.result.value!)
                    print("*** COMMENT • response.result.value! UP : ")
                    
                    if response.result.value != nil{
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        if let resData = swiftyJsonVar.arrayObject {
                            for d in resData {
                                
                                if let CmntDic = d as? [String : Any]{
                                    let cmnt = Comment(CommentDictionary: CmntDic)
                                    print(cmnt.content!)
                                    self.cmntList.append(cmnt)
                                    self.tab.reloadData()
                                    
                                }
                                
                            }
                         
                            
                            self.txt_nbr_cmnt.text = String(CommentaireViewController.track!.nbr_cmnt!)
                            self.txt_nbr_like.text = String(CommentaireViewController.track!.nbr_like!)
                            
                        //UIViewController.removeSpinner(spinner: sv)
                            
                        }
                        
                    }else{
                        
                        print("Eroor parsing !")
                        
                    }
                    
                    
//                     let url_service_check = server_likes+String(ViewController.session!.id!)+"/"+String(CommentaireViewController.track!.id!)
                    
                    //CHECK LIKE
                    Alamofire.request(url_service_check, method: .get, parameters: nil , encoding: JSONEncoding.default)
                        .validate(statusCode: 200...500)
                        .responseJSON { response in
                            
                            switch response.result {
                            case .success( _):
                                
                                print("*** LIKE • response.result.value! DOWN : ")
                                print(response.result.value!)
                                print("*** LIKE • response.result.value! UP : ")
                                
                                
                                if response.result.value != nil{
                                    let swiftyJsonVar = JSON(response.result.value!)
                                    
                                    if let resData2 = swiftyJsonVar.arrayObject {
                                        if(resData2.count !=  0 ){
                                            
                                            self.btn_aimer.isUserInteractionEnabled = false
                                            self.btn_aimer.setTitle("Already 👍", for: .normal)
                                            self.btn_aimer.setTitleColor(UIColor.gray, for: .normal)
                                            
                                        }
//                                        UIViewController.removeSpinner(spinner: sv)
                                        
                                    }
                                    
                                }else{
                                    print("Eroor parsing !")
                                }
                            case .failure(_):
                                print("Request Succeed")
                            }
                    }
                // END CHECK
                case .failure(_):
                    print("Request Succeedd")
                }
                
                
        }
    }

    
    
    
    
    
//END
}

extension CommentaireViewController: PopUpDelegate {
    
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
    
    
}

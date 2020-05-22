//
//  AdminViewController.swift
//  PIM_4
//
//  Created by Mac on 2/28/20.
//  Copyright © 2020 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class AdminViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    
    
    @IBOutlet weak var searchInput: UITextField!
    
    @IBAction func searchbutton(_ sender: Any) {
        
        if(self.searchInput.text != "" ){
        fetchDataSearch()
        }
        
        
    }
    
    
    
    
    
    var track:Dictionary<String,Any> = [:]
    
    @IBOutlet weak var tabviewww: UITableView!
    var server = "http://localhost:3000/"
    
    
    var tracklist:NSArray = []
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracklist.count
    }
    
    
    
    
    
    
    
    ////////*******////////
    
    
    
    //SLIDE EDIT SUPP table view isar imin
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        //DELETEEEEEEE
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.showDeleteWarning(for: indexPath)
        }
        
        
        
        //EDIIIIIIIIT
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            var track = self.tracklist[indexPath.item] as! Dictionary<String,Any>
            self.track = track
            self.performSegue(withIdentifier: "toEditEvent", sender: self)
            
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
    
    
    func showDeleteWarning(for indexPath: IndexPath) {
        //Create the alert controller and actions
        let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want delete this Event  ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            DispatchQueue.main.async {
                
                var track = self.tracklist[indexPath.item] as! Dictionary<String,Any>
                var id = track["id"]as! Int
                
                //service supprimer Delete localhost
                let url = "http://localhost:3000/track/:"+String(id)
                
                Alamofire.request(url, method: .delete).responseJSON
                    {
                        response in
                        
                        if(response.result.value is NSNull){
                            self.fetchData()
                            return;
                        }
                        
                        self.fetchData()
                }
            }
        }
        
        //Add the actions to the alert controller
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        //Present the alert controller
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //Prepare segue BEFORE TO EDIT
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //TEKHDEM JAWHA BEHI JUSTE NAHI LES COTES
//        if segue.identifier == "toEditEvent"
//        {
//            print(self.track)
//            let vc = segue.destination as? AddViewController
//            vc?.eventX = self.event
//            vc?.edit = true
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ////////*******////////
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCTableViewCell",for: indexPath) as! AdminCTableViewCell
        
//        @IBOutlet weak var Labelimage: UIImageView!
//
//        //title
//        @IBOutlet weak var labelName: UILabel!
//
//        //auteur
//        @IBOutlet weak var LabelDescription: UILabel!
//
//        //genre
//        @IBOutlet weak var LabelDate: UILabel!
//
//        //
//        @IBOutlet weak var LabelLocation: UILabel!
//
//        //nbr_like
//        @IBOutlet weak var LabelPart: UILabel!
//
//        //prix
//        @IBOutlet weak var LabelPrix: UILabel!
//
//        //nbr_cmnt
//        @IBOutlet weak var LabelTel: UILabel!
        
        //viewwithtag text
        let lbname = cell.viewWithTag(5) as! UILabel
        let lbdesc = cell.viewWithTag(6) as! UILabel
        let lbdate = cell.viewWithTag(7) as! UILabel
        let lbloca = cell.viewWithTag(8) as! UILabel
        let lbpart = cell.viewWithTag(9) as! UILabel
        let lbprix = cell.viewWithTag(10) as! UILabel
        let lbtel = cell.viewWithTag(11) as! UILabel
        
        //viewwithtag Image
        let img = cell.viewWithTag(12) as! UIImageView
        
        var eventData = tracklist[indexPath.item] as! Dictionary<String,Any>
        
        
     
          lbpart.text = String(eventData["nbr_like"] as! Int )
          lbdesc.text = eventData["auteur"] as! String
          lbprix.text = String(eventData["prix"] as! Int )
          lbloca.text = eventData["genre"] as! String
          lbname.text = eventData["title"] as! String
          lbtel.text = String(eventData["nbr_cmnt"] as! Int )
          lbdate.text = eventData["genre"] as! String
        
        
        //AlamofireImage
        Alamofire.request(server+"img/"+(eventData["image"]  as! String )).responseImage { response in
            if let image = response.result.value {
                
                
                img.image = image
            }
        }
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
    }
    
    
    func  fetchData () {
        
        let service = server+"track/"
        
        print(service+"SERVIIIIICEEEEEEE")
//      self.workList.removeAll()
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        Alamofire.request(service, method: .get, parameters: nil , encoding: JSONEncoding.default)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                case .success( _):
                    //                    print(response.result.value)
                    if response.result.value != nil{
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        if let resData = swiftyJsonVar.arrayObject {
                            
                            self.tracklist = response.result.value as! NSArray
//                          self.workList.append(work)
                            self.tabviewww.reloadData()
                                
                            }
                            UIViewController.removeSpinner(spinner: sv)
                            
                        
                        
                    }else{
                        print("Eroor parsing !")
                    }
                case .failure(_):
                    print("Request failed")
                }
                
                
        }
    }
    
    
    
    
    
    func  fetchDataSearch () {
        
        let service = server+"searchtrack/"+self.searchInput.text!
        
        print(service+"SERVIIIIICEEEEEEE")
        //      self.workList.removeAll()
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        Alamofire.request(service, method: .get, parameters: nil , encoding: JSONEncoding.default)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                case .success( _):
                    //                    print(response.result.value)
                    if response.result.value != nil{
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        if let resData = swiftyJsonVar.arrayObject {
                            
                            self.tracklist = response.result.value as! NSArray
                            //                          self.workList.append(work)
                            self.tabviewww.reloadData()
                            
                        }
                        UIViewController.removeSpinner(spinner: sv)
                        
                        
                        
                    }else{
                        print("Eroor parsing !")
                    }
                case .failure(_):
                    print("Request failed")
                }
                
                
        }
    }
    
}

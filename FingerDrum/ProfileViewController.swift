//
//  ProfileViewController.swift
//  FingerDrum
//
//  Created by Mac on 4/25/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ProfileViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource {
    
    
    
    var server2 = "http://localhost:3000/"
    var server = "http://localhost:3000/users/"
    var server3 = "http://localhost:3000/userss/"
    
    
    @IBOutlet weak var colWork: UICollectionView!
    
    @IBOutlet weak var txt_nom: UILabel!
    @IBOutlet weak var txt_role: UILabel!
    
    @IBOutlet weak var txt_Fname: UILabel!
    
    @IBOutlet weak var txt_Lname: UILabel!
    @IBOutlet weak var txt_phone: UILabel!
    @IBOutlet weak var txt_country: UILabel!
    
    var tracklist = [Track]()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracklist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  5
        let collectionViewSize = colWork.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colWork.dequeueReusableCell(withReuseIdentifier: "workProfItem", for: indexPath)
        
        let lb_title = cell.viewWithTag(2) as! UILabel
        let img = cell.viewWithTag(1) as! UIImageView
        lb_title.text = tracklist[indexPath.row].title
        
        
        Alamofire.request(server2+"img/"+(tracklist[indexPath.row].image!)).responseImage { response in
            if let image = response.result.value {
                img.image = image
            }
        }
        
        
        return cell
    }
   
    var x = ""
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txt_nom.text = (ViewController.session!.last_name!)+" "+(ViewController.session!.first_name!)
        
        x = String(ViewController.session!.role!)
        if( x == "1"){
            txt_role.text = "Compositeur"
        }else{
            txt_role.text = "Amateur"
        }
        
        txt_Fname.text = ViewController.session!.first_name!
        txt_Lname.text = ViewController.session!.last_name!
        txt_phone.text = String(ViewController.session!.phone!)
        txt_country.text = ViewController.session!.country!
        fetchData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeViewController.track = tracklist[indexPath.row]
//        performSegue(withIdentifier: "showWorkDetails", sender: indexPath)
        
    }
    
    
    
    
    func  fetchData () {
        print("ferch data userId : "+String(ViewController.session!.id!))
        let client_data = [
            "id": String(ViewController.session!.id!)
        ]
        
        
        let service = server3+String(ViewController.session!.id!)
        self.tracklist.removeAll()
        let sv = UIViewController.displaySpinner(onView: self.view)
        Alamofire.request(service, method: .get, parameters: nil , encoding: JSONEncoding.default)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                case .success( _):
                    print(response.result.value)
                    if response.result.value != nil{
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        if let resData = swiftyJsonVar.arrayObject {
                            for d in resData {
                                
                                if let TrackDic = d as? [String : Any]{
                                    let track = Track(TrackDictionary: TrackDic)
                                    print(track.title)
                                    self.tracklist.append(track)
                                    self.colWork.reloadData()
                                    
                                }
                                
                            }
                            UIViewController.removeSpinner(spinner: sv)
                            
                        }
                        
                    }else{
                        print("Eroor parsing !")
                    }
                case .failure(_):
                    print("Request failed")
                }
                
                
        }
    }
    
    
    
    
    
    
    
    func downloadImage(from url: URL , trg: UIImageView) {
        print("Download Started")
        getDataImg(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                trg.image = UIImage(data: data)
            }
        }
    }
    
    func getDataImg(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

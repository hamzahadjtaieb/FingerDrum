//
//  HomeViewController.swift
//  FingerDrum
//
//  Created by Mac on 3/30/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import AVKit


public class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate {
    
    
    static var track:Track? = nil
    
    @IBOutlet weak var txt_nom: UILabel!
    //   var workList = [Event]()
    var tracklist = [Track]()
    var songs = [Song]()
    
    
    
    @IBOutlet weak var colWrok: UICollectionView!
    var server = "http://localhost:3000/"
    
    //    collectionViewCarType.delegate = self;
    //    collectionViewCarType.dataSource = self;
    //  1 - CollectionView
    
    
    override public func viewWillAppear(_ animated: Bool) {
        
        // Set up video in the background
        //        setUpVideo()
    }
    
    // 2 - Identifier CollectionView dans la cellulce pas ici
    //  static let identifier = "FirstInsideCollectionViewCell"
    
    
    
    @IBAction func logoutUser(_ sender: Any) {
        
         
        
    }
    


    @IBOutlet weak var table: UITableView!
    
    //MARK - Table View Cell
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songs.count
        
//        return workList.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath)
        
        let song = songs[indexPath.row]
        //Configure
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        
        cell.textLabel?.font = UIFont(name:"Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name:"Helvetica", size: 17)
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present the player
        let position = indexPath.row
        //songs
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
    
    
    
    
    //END MARK - Table View Cell
    
    
    
    
    
    
    
    
    
    
    //MARK - Colelction View Cell
    // NUMBER OF ITEMS IN SECTION
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracklist.count
    }
    
    
    
    // CELL FOR ITEM AT
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colWrok.dequeueReusableCell(withReuseIdentifier: FirstInsideCollectionViewCell.identifier, for: indexPath) as! FirstInsideCollectionViewCell
        
    
        //Titre
        cell.configure2(with: tracklist[indexPath.item], collectionView: collectionView, index: indexPath.row)
        
        //CHOUCHA
//        let lb_title = cell.viewWithTag(2) as! UILabel
//        let img = cell.viewWithTag(1) as! UIImageView
//        lb_title.text = workList[indexPath.row].title
        
        let img = cell.viewWithTag(1) as! UIImageView
        
        print(tracklist[indexPath.row].image!+" + NOM IMAGE : ICI ICI ICI IMAGE ")
        print(tracklist[indexPath.row].title!+" + TITLE IS ")
        
        Alamofire.request(server+"img/"+(tracklist[indexPath.row].image!)).responseImage { response in
            if let image = response.result.value {
                img.image = image
            }
        }
        
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        CommentaireViewController.track = tracklist[indexPath.row]
        performSegue(withIdentifier: "CommentaireViewController", sender: indexPath)
        
    }
    
    
    
    @IBOutlet weak var Role_Label: UILabel!
    
    var Role_User = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configureSongs()
        
        if( Role_User == "1"){
        Role_Label.text = "Compositeur"
        }else{
        Role_Label.text = "Amateur"
        }
        
        
        

    }
    
    
    
    
    
    
    
    
    
    
    
    
    //SONG
    func configureSongs(){
        
        songs.append(Song(name: "Background Music",
                          albumName: "123 other",
                          artistName: "Rnaldo",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "Havana ",
                          albumName: "Havana album",
                          artistName: "Camilla Cabello",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Viva La vida",
                          albumName: "123 Somethig",
                          artistName: "Coldplay",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Background Music",
                          albumName: "123 other",
                          artistName: "Rnaldo",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "Havana ",
                          albumName: "Havana album",
                          artistName: "Camilla Cabello",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Viva La vida",
                          albumName: "123 Somethig",
                          artistName: "Coldplay",
                          imageName: "cover3",
                          trackName: "song3"))
    }
    
    
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //NOM + PRENOM dans le Label txt_nom
        txt_nom.text = (ViewController.session!.first_name!)+" "+(ViewController.session!.last_name!)
        
        fetchData()
        
    }
    
    
    
    
    func  fetchData () {
    
        print("ferch data userId : "+String(ViewController.session!.id!) )
    
        let service = server+"track/"
        
        print(service+" __ Mon Service Track : __ ")
        self.tracklist.removeAll()
        
        
        Alamofire.request(service, method: .get, parameters: nil , encoding: JSONEncoding.default)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                
                switch response.result {
                case .success( _):
                    
                    if response.result.value != nil{
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        if let resData = swiftyJsonVar.arrayObject {
                            for data in resData {
                                
                                if let TrackDic = data as? [String : Any]{
                                    let track = Track(TrackDictionary: TrackDic)
                                    //print(work.description)
                                    self.tracklist.append(track)
                                    self.colWrok.reloadData()
                                    print(data)
                                    print("xxx")
                                    print(track)
//                                    try! self.collectionView()
                                }
                                
                            }

                            
                        }
                        
                    }else{
                        print("Eroor parsing !")
                    }
                case .failure(_):
                    print("Request failed")
                }
                
                
        }
    }
    
    
    
//    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if( Role_User == "1"){
//            self.performSegue(withIdentifier: "toMusic", sender: nil)
//        }else{
//            print("NO WAY")
//        }
//    }
    
    @IBAction func toMusic(_ sender: Any) {
        
        if( Role_User == "1"){
            self.performSegue(withIdentifier: "toMusic", sender: nil)
        }else{
            self.reloadInputViews()
        }
        
        
//        do {
//            try self.performSegue(withIdentifier: "toMusic", sender: nil)
//            print("Success! Yum.")
//        } catch {
//            print("Invalid Selection.")
//        }
        
    }
    
    
    
//        override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        if segue.identifier == "toMusic"
//
//        {
//            if ()
//
//            let vc = segue.destination as! HomeViewController
//            vc.Role_User = String(ViewController.session!.role!)
//            //        vc.session2 = ViewController.session
//
//        }
//
//        if segue.identifier == "logprofile"{
//
//        }
//
//
//    }
    

}

struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
    
}

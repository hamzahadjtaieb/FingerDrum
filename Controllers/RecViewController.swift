//
//  RecViewController.swift
//  AMZA
//
//  Created by Mac on 4/8/20.
//  Copyright © 2020 iosdecal. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

public class RecViewController: UIViewController {
    
    
    
    
    struct Record {
        
        
        var path : String? = ""
        var ttime : String? = ""
        
        init(
            path: String? = nil,
            ttime: String? = nil)
        {
            self.path = path
            self.ttime = ttime
        }
    }
    
    
    var tab: [Record] = []
    
    var tabPath: [String] = []
    
    var pathPlayed = ""
    
    
    
    
    
    
    
    
    
    var audioPlayer: AVAudioPlayer?
    
    
    // MARK : - OUTLET
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBOutlet weak var lapButton: UIButton!
    
    @IBOutlet weak var TimeTry: UILabel!
    
    // MARK : - Variables
    var hours = 0
    var minutes = 0
    var seconds = 0
    
    var hourss = 0
    var minutess = 0
    var secondss = 0
    
    var getSeconds:[String] = []
    var getMinutes:[String] = []
    
    var lappedTimes:[String] = []
    var DrumNamePressed:[String] = []
    
    
    
    
    // Timer
    var timer = Timer()
    
    
    
    override public func viewDidLoad() {
        
        
        
        
        super.viewDidLoad()
        lapButton.isHidden = false
        // Do any additional setup after loading the view.
        
        
        hours = 0
        minutes = 0
        seconds = 0
        
        
        
        //        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
        //            //                // Do what you need to do repeatedly
        //
        //            self.seconds += 1
        //            if self.seconds == 60 {
        //                self.minutes += 1
        //                self.seconds = 0
        //            }
        //
        //            if self.minutes == 60 {
        //               self.minutes = 0
        //               self.seconds = 0
        //               self.hours += 1
        //
        //            }
        //
        //            if self.hours == 24 {
        //                self.resetTime()
        //            }
        //
        //            self.secondLabel.text = "\(self.seconds)"
        //            self.minuteLabel.text = self.minutes == 0 ? "00" : "\(self.minutes)"
        //            self.hourLabel.text = self.hours == 0 ? "00" : "\(self.hours)"
        //
        //            let currentTime = "\(self.hours):\(self.minutes):\(self.seconds)"
        //            print(currentTime)
        //
        //        }
        
        //        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true){ (timer) in
        //            //            //                // Do what you need to do repeatedly
        //            //
        //                    print(currentTime)
        //            //
        //                    }
    }
    
    func resetTime(){
        hours = 0
        minutes = 0
        seconds = 0
        lappedTimes = []
        timer.invalidate()
        secondLabel.text = "00"
        minuteLabel.text = "00"
        hourLabel.text = "00"
        tableView.reloadData()
        startButton.isHidden = false
//        lapButton.isHidden = true
    }
    
    func resetTabs(){
        DrumNamePressed = []
        tab = []
        pathPlayed = ""
        
    }
    
    func GetUrlDrum(pathDrum: String){
        
        let CurrentNameDrum = pathDrum
        DrumNamePressed.append(CurrentNameDrum)
        
    }
    
    var Xtime:String = ""
    
    func getTime(Timing: String){
        
        Xtime = Timing
        
        
    }
    
    
    @IBAction func DrumWasPressed(_ sender: UIButton) {
        
        //        let selectedInstrument = sender.tag
        //
        //        switch selectedInstrument {
        //
        //        case 1:
        //
        //            let pathToSound = Bundle.main.path(forResource: "drumkit-0", ofType: "wav")!
        //            let url = URL(fileURLWithPath: pathToSound)
        //            print(url)
        //
        //            let path:String = url.path
        //            GetUrlDrum(pathDrum: path)
        //
        //            var RRR = Record()
        //            RRR = Record.init(path: path)
        //            tab.append(RRR)
        //
        //
        //            print("tab is :")
        //            print(tab)
        //            print("Path is :")
        //            print(path)
        //
        //
        //            do{
        //                audioPlayer = try AVAudioPlayer(contentsOf: url)
        //                audioPlayer?.play()
        //            }   catch   {
        //                //RRR
        //            }
        //
        //        case 2:
        //            let pathToSound = Bundle.main.path(forResource: "drumkit-1", ofType: "wav")!
        //            let url = URL(fileURLWithPath: pathToSound)
        //            print(url)
        //
        //            do{
        //                audioPlayer = try AVAudioPlayer(contentsOf: url)
        //                audioPlayer?.play()
        //            }   catch   {
        //                //RRR
        //            }
        //
        //        default:
        //            return
        //        }
        
    }
    
    
    
    
    
    
    @IBAction func start(_ sender: UIButton) {
        
        //        Starting the timer
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        
        startButton.isHidden = false
        lapButton.isHidden = false
        
    }
    
    @objc fileprivate func count(){
        
        seconds += 1
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        if minutes == 60 {
            minutes = 0
            seconds = 0
            hours += 1
            
        }
        
        if hours == 24 {
            resetTime()
        }
        
        secondLabel.text = "\(seconds)"
        minuteLabel.text = minutes == 0 ? "00" : "\(minutes)"
        hourLabel.text = hours == 0 ? "00" : "\(hours)"
        
        
    }
    
    
    
    
    
    
    //PAUSE
    @IBAction func pause(_ sender: UIButton) {
        
        timer.invalidate()
        startButton.isHidden = false
//        lapButton.isHidden = true
        
    }
    
    
    ///RESET
    @IBAction func reset(_ sender: UIButton) {
        
        resetTime()
        resetTabs()
        
    }
    
    
    
    
    //BUTTON 1
    @IBAction func lap(_ sender: UIButton) {
        
//        lapButton.showsTouchWhenHighlighted = true
        
        let pathToSound = Bundle.main.path(forResource: "drumkit-0", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        print(url)
        
        let path:String = url.path
        GetUrlDrum(pathDrum: path)
        
        var RRR = Record()
        RRR = Record.init(path: path)
        
        print("tab is :")
        print(tab)
        print("Path is :")
        
        pathPlayed = path
        print(pathPlayed)
        
        
        tabPath.append(path)
        
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }   catch   {
            //RRR
        }
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        
        print("Njareb fel Current time houni khater mahabech yekhdem fel Record")
        print(  currentTime)
        
        lappedTimes.append(currentTime)
        
        print("LappedTimes TABLEAU TEMPS WHEN PRESSED: +  DRUM1")
        print(lappedTimes)
        print("-------")
        print("drum1 PATH :")
        print(DrumNamePressed)
        
        
        
        print("---TABLEAU RECORD----***********************************************************************")
        
        var RRR2 = Record()
        RRR2 = Record.init(path: path, ttime: currentTime)
        tab.append(RRR2)
        
        
        print("Tab Timing is :")
        print(tab)
        
        
        print("---TABLEAU RECORD----+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        
        
        for index in 0..<(tab.count) {
            
            //YOUR LOGIC....
            //            let PathInTab = tab[i].path!
            print(tab[index].path!)
            
            //            let TimeInTab = tab[index].ttime!
            print(tab[index].ttime!)
        }
        
        
        
        //            TABLE VIEW tekhdem jawha behi
        //            let indexpPath = IndexPath(row: lappedTimes.count - 1, section: 0)
        //            tableView.insertRows(at: [indexpPath], with: .automatic)
        //
        //            tableView.reloadData()
    }
    
    
    @IBAction func lap2(_ sender: UIButton) {
        
        //SOUND BUTTON 2
        let pathToSound = Bundle.main.path(forResource: "drumkit-1", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        print(url)
        
        let path:String = url.path
        GetUrlDrum(pathDrum: path)
        
        var RRR = Record()
        RRR = Record.init(path: path)
        
        
        print("tab is :")
        print(tab)
        
        print("Path is :")
        pathPlayed = path
        print(pathPlayed)
        
        
        tabPath.append(path)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }   catch   {
            //RRR
        }
        
        
        
        ///END SOUND BUTTON 2
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        print("LappedTimes TABLEAU TEMPS WHEN PRESSED: + DRUM2")
        print(lappedTimes)
        print("-------")
        print("***drum2 PATH :")
        print(DrumNamePressed)
        
        
        print("---TABLEAU RECORD2222222----******************************************************************")
        
        var RRR2 = Record()
        RRR2 = Record.init(path: path, ttime: currentTime)
        tab.append(RRR2)
        
        print("Tab Timing is :")
        print(tab)
        
        print("---TABLEAU RECORD2222222----++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        
        
        
        for index in 0..<(tab.count) {
            
            //YOUR LOGIC....
            //            let PathInTab = tab[i].path!
            print(tab[index].path!)
            
            //            let TimeInTab = tab[index].ttime!
            print(tab[index].ttime!)
            
        }
        
        
        
        
    }
    
    
    
    
    
    //BUTTON3
    @IBAction func lap3(_ sender: Any) {
        
        let pathToSound = Bundle.main.path(forResource: "drumkit-2", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        print(url)
        
        let path:String = url.path
        GetUrlDrum(pathDrum: path)
        
        var RRR = Record()
        RRR = Record.init(path: path)
        
        
        print("tab is :")
        print(tab)
        
        print("Path is :")
        pathPlayed = path
        print(pathPlayed)
        
        
        tabPath.append(path)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }   catch   {
            //RRR
        }
        
        
        
        ///END SOUND BUTTON 2
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        print("LappedTimes TABLEAU TEMPS WHEN PRESSED: + DRUM2")
        print(lappedTimes)
        print("-------")
        print("***drum2 PATH :")
        print(DrumNamePressed)
        
        
        print("---TABLEAU RECORD2222222----******************************************************************")
        
        var RRR2 = Record()
        RRR2 = Record.init(path: path, ttime: currentTime)
        tab.append(RRR2)
        
        print("Tab Timing is :")
        print(tab)
        
        print("---TABLEAU RECORD2222222----++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        
        
        
        for index in 0..<(tab.count) {
            
            //YOUR LOGIC....
            //            let PathInTab = tab[i].path!
            print(tab[index].path!)
            
            //            let TimeInTab = tab[index].ttime!
            print(tab[index].ttime!)
            
        }
        
        
        
        
    }
    
    //BUTTON4
    @IBAction func lap4(_ sender: Any) {
        let pathToSound = Bundle.main.path(forResource: "drumkit-3", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        print(url)
        
        let path:String = url.path
        GetUrlDrum(pathDrum: path)
        
        var RRR = Record()
        RRR = Record.init(path: path)
        
        
        print("tab is :")
        print(tab)
        
        print("Path is :")
        pathPlayed = path
        print(pathPlayed)
        
        
        tabPath.append(path)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }   catch   {
            //RRR
        }
        
        
        
        ///END SOUND BUTTON 2
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        print("LappedTimes TABLEAU TEMPS WHEN PRESSED: + DRUM2")
        print(lappedTimes)
        print("-------")
        print("***drum2 PATH :")
        print(DrumNamePressed)
        
        
        print("---TABLEAU RECORD2222222----******************************************************************")
        
        var RRR2 = Record()
        RRR2 = Record.init(path: path, ttime: currentTime)
        tab.append(RRR2)
        
        print("Tab Timing is :")
        print(tab)
        
        print("---TABLEAU RECORD2222222----++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        
        
        
        for index in 0..<(tab.count) {
            
            //YOUR LOGIC....
            //            let PathInTab = tab[i].path!
            print(tab[index].path!)
            
            //            let TimeInTab = tab[index].ttime!
            print(tab[index].ttime!)
            
        }
        
        
        
    }
    
    //BUTTON5
    @IBAction func lap5(_ sender: Any) {
        let pathToSound = Bundle.main.path(forResource: "drumkit-5", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        print(url)
        
        let path:String = url.path
        GetUrlDrum(pathDrum: path)
        
        var RRR = Record()
        RRR = Record.init(path: path)
        
        
        print("tab is :")
        print(tab)
        
        print("Path is :")
        pathPlayed = path
        print(pathPlayed)
        
        
        tabPath.append(path)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }   catch   {
            //RRR
        }
        
        
        
        ///END SOUND BUTTON 2
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        print("LappedTimes TABLEAU TEMPS WHEN PRESSED: + DRUM2")
        print(lappedTimes)
        print("-------")
        print("***drum2 PATH :")
        print(DrumNamePressed)
        
        
        print("---TABLEAU RECORD2222222----******************************************************************")
        
        var RRR2 = Record()
        RRR2 = Record.init(path: path, ttime: currentTime)
        tab.append(RRR2)
        
        print("Tab Timing is :")
        print(tab)
        
        print("---TABLEAU RECORD2222222----++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        
        
        
        for index in 0..<(tab.count) {
            
            //YOUR LOGIC....
            //            let PathInTab = tab[i].path!
            print(tab[index].path!)
            
            //            let TimeInTab = tab[index].ttime!
            print(tab[index].ttime!)
            
        }
        
        
        
    }
    
    //BUTTON6
    @IBAction func lap6(_ sender: Any) {
        let pathToSound = Bundle.main.path(forResource: "drumkit-6", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
        print(url)
        
        let path:String = url.path
        GetUrlDrum(pathDrum: path)
        
        var RRR = Record()
        RRR = Record.init(path: path)
        
        
        print("tab is :")
        print(tab)
        
        print("Path is :")
        pathPlayed = path
        print(pathPlayed)
        
        
        tabPath.append(path)
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }   catch   {
            //RRR
        }
        
        
        
        ///END SOUND BUTTON 2
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        print("LappedTimes TABLEAU TEMPS WHEN PRESSED: + DRUM2")
        print(lappedTimes)
        print("-------")
        print("***drum2 PATH :")
        print(DrumNamePressed)
        
        
        print("---TABLEAU RECORD2222222----******************************************************************")
        
        var RRR2 = Record()
        RRR2 = Record.init(path: path, ttime: currentTime)
        tab.append(RRR2)
        
        print("Tab Timing is :")
        print(tab)
        
        print("---TABLEAU RECORD2222222----++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        
        
        
        for index in 0..<(tab.count) {
            
            //YOUR LOGIC....
            //            let PathInTab = tab[i].path!
            print(tab[index].path!)
            
            //            let TimeInTab = tab[index].ttime!
            print(tab[index].ttime!)
            
        }
        
        
        
    }
    
    
    func Play(){
        let currentTimess = "\(hours):\(minutes):\(seconds)"
        
        print("currentTimeforRecod : :: : : :: : : ")
        print(currentTimess)
        print("currentTimeforRecod : :: : : :: : : ")
        
        
        for index in 0..<(tab.count) {
            
            if (self.tab[index].ttime! == currentTimeforRecod()){
            
                        let NamepathPlayed = tab[index].path!
                        print("NamepathPlayed")
                        print(NamepathPlayed)
        
        
        
                        let sound = Bundle.main.path(forResource: NamepathPlayed , ofType: "wav")
        //                let sound = Bundle.main.path
                        print("WWOWOOWOWOWO")
                        print(sound)
        
        
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound! ))
                            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.mixWithOthers])
        
                        } catch {
        
                            print(error)
        
                        }
            }
            
        }
        
        //END CLASS PLAY
    }
    
    
    
    
    
    // Time Record
    var XRecordtime:String = ""
    
    func currentTimeforRecod() -> String{
        
        let currentTimex = "\(hours):\(minutes):\(seconds)"
        XRecordtime = currentTimex
        return XRecordtime
    }
    
    
    
    
    
    
    func sayHello()
    {
        NSLog("hello World")
    }
    
    //Play Pause
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        //        btn.showsTouchWhenHighlighted = true
        
        hours = 0
        minutes = 0
        seconds = 0
        
        //        secondLabel.text = "00"
        //        minuteLabel.text = "00"
        //        hourLabel.text = "00"
        
        
        //
        //        var timer: Timer?
        //
        //        override func viewDidLoad() {
        //            super.viewDidLoad()
        //
        //            timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
        //                // Do what you need to do repeatedly
        //            }
        //        }
        
        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            //                // Do what you need to do repeatedly
            
            self.seconds += 1
            if self.seconds == 60 {
                self.minutes += 1
                self.seconds = 0
            }
            
            if self.minutes == 60 {
                self.minutes = 0
                self.seconds = 0
                self.hours += 1
                
            }
            
            if self.hours == 24 {
                self.resetTime()
            }
            
            self.secondLabel.text = "\(self.seconds)"
            self.minuteLabel.text = self.minutes == 0 ? "00" : "\(self.minutes)"
            self.hourLabel.text = self.hours == 0 ? "00" : "\(self.hours)"
            
            let currentTimex = "\(self.hours):\(self.minutes):\(self.seconds)"
            print(currentTimex)
            
            self.getTime(Timing: currentTimex)
            
            for index in 0..<(self.tab.count) {
                
                
                print("IME")
                print(currentTimex)
                print("IME")
                
                
                print("self.tab[index].ttime!")
                print(self.tab[index].ttime!)
                
                print("\n")
                
                print("self.tab[index].path!")
                print(self.tab[index].path!)
                
                
                print("self.tabPath[index]")
                print(self.tabPath[index])
                
                
                //                (self.tab[index].path! == self.tab[index].path!)
                //                && (self.tab[index].path!  == self.tabPath[index])
                if (self.tab[index].ttime! == currentTimex) {
                    
                    print("Yesssss")
                    print(index)
                    
                    
                    
                    
                    //PLAY
                    
                    var NamepathPlayed = self.tab[index].path!
                    print("NamepathPlayed")
                    print(NamepathPlayed)
                    
                    var XXX = String(NamepathPlayed.suffix(13))
                    print("XXX")
                    
                    print(XXX)
                    
                    print("XXX")
                    
                    var YYY = XXX
                    
                    
                    
                    
                    let NamepathPlayeds = self.tab[index].path!
                    print("NamepathPlayeds")
                    print(NamepathPlayeds)
                    
                    // Get range 4 places from the start, and 6 from the end.
                    let r = NamepathPlayeds.index(NamepathPlayeds.startIndex, offsetBy: 175)..<NamepathPlayeds.index(NamepathPlayeds.endIndex, offsetBy: -4)
                    
                    // Access the string by the range.
                    let substring = String(NamepathPlayeds[r])
                    print("substring")
                    print(substring)
                    print("substring")
                    
                    
                    
                    let sound = Bundle.main.path(forResource: substring , ofType: "wav")!
            
                    let url = URL(fileURLWithPath: sound)
                    
                    do{
                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        self.audioPlayer?.play()
                    }   catch   {
                        //RRR
                    }
                    

                    
                }
            }
            
            
            
        }
        
        
        
        
        
        
        //VERION ELLI (BAL HEDHI
        //        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        let currentTimess = "\(hours):\(minutes):\(seconds)"
        
        
        print("playButtonPressed : Print TAB : ")
        print(tab)
        
        //TIME STARTS
        
        // GET THE TIME
        print("-------- currentTimess Is :")
        print(currentTimess)
        print("currentTimess Is : ---------")
        
        
        // GET THE TIME - Try 2
        var CurrentTimeRec:String = ""
        CurrentTimeRec = currentTimeforRecod()
        print("IMExx NEW NEW NEW")
        print(CurrentTimeRec)
        
        
        getTime(Timing: currentTimess)
        
        //        for index in 0..<(tab.count) {
        //
        //
        //            print("IME")
        //            print(CurrentTimeRec)
        //            print("IME")
        //            print(tab[index].ttime!)
        //            print(tab[index].path!)
        //
        //            if (tab[index].ttime! == Xtime){
        //
        //                print("Yesssss")
        //                print(index)
        //
        //
        //                audioPlayer?.play()
        //
        //            }
        //        }
        
        ///playButtonPressed
    }
    
    
    
    
    @objc fileprivate func count2(){
        
        
        
        secondss += 1
        if secondss == 60 {
            minutess += 1
            secondss = 0
        }
        
        if minutess == 60 {
            minutess = 0
            secondss = 0
            hourss += 1
            
        }
        
        if hourss == 24 {
            resetTime()
        }
        
        secondLabel.text = "\(secondss)"
        minuteLabel.text = minutess == 0 ? "00" : "\(minutess)"
        hourLabel.text = hourss == 0 ? "00" : "\(hourss)"
        
        
    }
    
    
    
    
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        
        let currentTime = "\(hours):\(minutes):\(seconds)"
        print(currentTime)
        
        print("Xtime")
        print(Xtime)
        print("Xtime")
        
        var x:String = ""
        print("x")
        x = currentTimeforRecod()
        print("x")
        
    }
    
    
    //end Class
}







// MARK: - UITableViewDelegate and UITableViewDataSouce functions
extension RecViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lappedTimes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell", for: indexPath)
        
        cell.textLabel?.text = lappedTimes[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            lappedTimes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    
    
    
    
    
}


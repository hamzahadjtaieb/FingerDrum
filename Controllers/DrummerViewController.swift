//
//  DrummerViewController.swift
//  AMZA
//
//  Created by Paige Plander on 1/13/17.
//  Copyright © 2017 iosdecal. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation


class DrummerViewController: UIViewController {
    
    
    var audioPlayer: AVAudioPlayer?
    

    // Our DrumKit object
   // let drumKit = DrumKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // YOUR CODE HERE


    @IBAction func drumButtonWasPressed(_ sender: UIButton) {
        

//        #1 drumkit-0
//        #2 drumkit-1
//        #3 drumkit-2
//        #4 drumkit-3
//        #5 drumkit-4
//        #6 drumkit-5
//        #7 drumkit-6
        
        
        
        
        
        let selectedInstrument = sender.tag
        
        switch selectedInstrument {
            
        case 1:
            let pathToSound = Bundle.main.path(forResource: "drumkit-0", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
        
        case 2:
            let pathToSound = Bundle.main.path(forResource: "drumkit-1", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
        case 3:
            let pathToSound = Bundle.main.path(forResource: "drumkit-2", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
        case 4:
            let pathToSound = Bundle.main.path(forResource: "drumkit-3", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
        
        case 5:
            let pathToSound = Bundle.main.path(forResource: "drumkit-4", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
            
        case 6:
            let pathToSound = Bundle.main.path(forResource: "drumkit-5", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
            
        case 7:
            let pathToSound = Bundle.main.path(forResource: "drumkit-6", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }   catch   {
                //RRR
            }
            
            
        
        default:
            return
        }
        
    //end drumButtonWasPressed
    }
    
    
//    let currentTime:Double = player.currentItem.currentTime().seconds
//    
//    func getHoursMinutesSecondsFrom(seconds: Double) -> (hours: Int, minutes: Int, seconds: Int) {
//        let secs = Int(seconds)
//        let hours = secs / 3600
//        let minutes = (secs % 3600) / 60
//        let seconds = (secs % 3600) % 60
//        return (hours, minutes, seconds)
//    }
//    
//    func formatTimeFor(seconds: Double) -> String {
//        let result = getHoursMinutesSecondsFrom(seconds: seconds)
//        let hoursString = "\(result.hours)"
//        var minutesString = "\(result.minutes)"
//        if minutesString.characters.count == 1 {
//            minutesString = "0\(result.minutes)"
//        }
//        var secondsString = "\(result.seconds)"
//        if secondsString.characters.count == 1 {
//            secondsString = "0\(result.seconds)"
//        }
//        var time = "\(hoursString):"
//        if result.hours >= 1 {
//            time.append("\(minutesString):\(secondsString)")
//        }
//        else {
//            time = "\(minutesString):\(secondsString)"
//        }
//        return time
//    }
//    
//    
//    func updateTime() {
//        // Access current item
//        if let currentItem = player.currentItem {
//            // Get the current time in seconds
//            let playhead = currentItem.currentTime().seconds
//            let duration = currentItem.duration.seconds
//            // Format seconds for human readable string
//            playheadLabel.text = formatTimeFor(seconds: playhead)
//            durationLabel.text = formatTimeFor(seconds: duration)
//        }
//    }
    
    
    
    
//end
}

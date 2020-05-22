//
//  MacawChartView.swift
//  IOT-MobileDashboard
//
//  Created by Mac on 5/7/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import Foundation
import Macaw
import Alamofire
import UIKit

public class MacawChartView:  MacawView{
    
    
    
    
    
    
    
    
    
    
    
    
    
//    let  = cell.viewWithTag(1) as! UIImageView
//    
//    print(tracklist[indexPath.row].image!+" + NOM IMAGE : ICI ICI ICI IMAGE ")
//    print(tracklist[indexPath.row].title!+" + TITLE IS ")
//    
//    Alamofire.request(server+"img/"+(tracklist[indexPath.row].image!)).responseImage { response in
//    if let image = response.result.value {
//    img.image = image
//    }
//    }
    
    
    
    
    
    
    static let lastFiveShows            = createDummydata()
    static let maxValue                 = 6000
    static let maxValueLineHeight       = 100
    static let lineWidth:  Double       = 275
    
    static let dataDivisor              = Double(maxValue/maxValueLineHeight)
    static let adjustedData:[Double]    = lastFiveShows.map({ $0.viewCount / dataDivisor})
    static var animations:[Animation]   = []
    
    
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(node: MacawChartView.createChart(), coder: aDecoder)
        backgroundColor = .clear
    }
    
    private static func createChart() -> Group {
        
        var items:[Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())

        return Group(contents: items , place: .identity)
    }
    
    private static func addYAxisItems() -> [Node] {
        
        let maxLines                 = 6
        let lineInterval             = Int(maxValue/maxLines)
        let yAxisHeight:  Double     = 200
        let lineSpacing:  Double     = 30
        
        
        var newNodes: [Node]         = []
        
        for i in 1...maxLines {
        
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueline = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.white.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
            
            newNodes.append(valueline)
            newNodes.append(valueText)
            
        }
        
        let yAxis = Line(x1: 0, y1: 1, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes
    }
    
    private static func addXAxisItems() -> [Node] {
        
        let chartBaseY: Double   = 200
        var newNodes: [Node]    = []
        
        for i in 1...adjustedData.count{
            
            let x = (Double(i) * 50)
            let valueText = Text(text: lastFiveShows[i - 1].showNumber, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15) )
            
            valueText.fill = Color.white
            
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
        
    }
    
    private static func createBars() -> Group {
        
        let fill = LinearGradient(degree: 90, from: Color(val: 0xff4704), to: Color(val: 0xff4704).with(a: 0.33))
        let items = adjustedData.map {  _ in Group() }
        
        animations = items.enumerated().map {   (i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
                let height      = adjustedData[i] * t
                let rect        = Rect(x: Double(i) * 50 + 25, y: 200 - height, w: 30, h: height)
                return [rect.fill(with: fill)]
            }
        }
        
        return items.group()
    }
    
    static func playAnimations(){
        animations.combine().play()
        
        
        
        print()
        
        
    }
    
    
    
    
    
    
    private static func createDummydata() -> [SwiftNewsVideo] {
        
//        let one     = SwiftNewsVideo(showNumber: "55", viewCount: Double(drand48()*10000))
//        let two     = SwiftNewsVideo(showNumber: "56", viewCount: 5300)
//        let three   = SwiftNewsVideo(showNumber: "57", viewCount: 4270)
//        let four    = SwiftNewsVideo(showNumber: "58", viewCount: 3688)
//        let five    = SwiftNewsVideo(showNumber: "59", viewCount: 4382)

        
        
        
        let one     = SwiftNewsVideo(showNumber: "👨‍💻", viewCount: Double(drand48()*10000))
        let two     = SwiftNewsVideo(showNumber: "🎹", viewCount: 5300)
        let three   = SwiftNewsVideo(showNumber: "👍", viewCount: 4270)
        let four    = SwiftNewsVideo(showNumber: "📋", viewCount: 3688)
//        let five    = SwiftNewsVideo(showNumber: "", viewCount: 4382)
        
        print(one.viewCount)
        
        return [one, two, three, four]
    }
    
    
    
}

//
//  ViewController.swift
//  IOT-MobileDashboard
//
//  Created by Mac on 5/7/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit

public class ChartViewController: UIViewController {
    
    
    
    
    
    @IBOutlet private var chartView: MacawChartView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        chartView.contentMode = .scaleAspectFit
        

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func showChartButtonTapped(_ sender: UIButton) {
        MacawChartView.playAnimations()
    }
    
}


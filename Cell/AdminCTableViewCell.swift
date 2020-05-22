//
//  AdminCTableViewCell.swift
//  PIM_4
//
//  Created by Mac on 2/28/20.
//  Copyright © 2020 Hamza. All rights reserved.
//

import UIKit

class AdminCTableViewCell: UITableViewCell {
    
    private var tableviewXX: UITableView?
    private var index: Int?
    
    
    
    @IBOutlet weak var Labelimage: UIImageView!
    
    //title
    @IBOutlet weak var labelName: UILabel!
    
    //auteur
    @IBOutlet weak var LabelDescription: UILabel!
    
    //genre
    @IBOutlet weak var LabelDate: UILabel!
    
    //
    @IBOutlet weak var LabelLocation: UILabel!
    
    //nbr_like
    @IBOutlet weak var LabelPart: UILabel!
    
    //prix
    @IBOutlet weak var LabelPrix: UILabel!
    
    //nob_cmnt
    @IBOutlet weak var LabelTel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    //    func configure3(with event: Event, tableView: UITableView, index: Int) {
    //        //cityTitle.text = event.description
    //        print("////////////////siki")
    //        //print(event.image)
    //
    //
    //
    //        LabelLocation.text = "\(event.id!)"
    //
    //
    //        LabelPart.text = "\(event.nombreparticipant!)"
    //        //LabelNombrePart.text = "\(event.nombreparticipant!)"
    //
    //        LabelPrix.text = "\(event.prix!)"
    //        //LabelPrix2.text = "\(event.prix!)"
    //
    //        labelName.text = event.title
    //        LabelDescription.text = event.description
    //        LabelTel.text = "\(event.phone!)"
    //
    //
    //        self.tableviewXX = tableView
    //        self.index = index
    //    }
    
}

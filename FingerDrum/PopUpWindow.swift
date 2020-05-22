//
//  PopUpWindow.swift
//  FingerDrum
//
//  Created by Mac on 5/4/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    func handleDismissal()
}

class PopUpWindow: UIView {
    
    var delegate: PopUpDelegate?
    
    
    let checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 96)
        label.textColor = UIColor(red: 147/255, green: 227/255, blue: 105/255, alpha: 1)
        label.text = "🤝"
        return label
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 24)
        label.text = "Liked Successfully "
        return label
    }()
    
    
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.magenta
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(checkLabel)
        checkLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -28).isActive = true
        checkLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(notificationLabel)
        notificationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        notificationLabel.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 0).isActive = true
        
        addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has nor been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }

}

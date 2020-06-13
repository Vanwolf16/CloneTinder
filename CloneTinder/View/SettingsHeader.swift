//
//  SettingsHeader.swift
//  CloneTinder
//
//  Created by David Murillo on 6/12/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

protocol SettingsHeaderDelegate:class{
    func settingsHeader(_ header:SettingsHeader,didSelect index:Int)
}

class SettingsHeader:UIView{
    //MARK: Protocol
    weak var delegate:SettingsHeaderDelegate?
    
    //MARK: Properties
    
    var buttons = [UIButton]()
    
  
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        
        let button1 = createButton(0)
          let button2 = createButton(1)
          let button3 = createButton(2)
        
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        
        addSubview(button1)
        
        button1.anchor(top: topAnchor,left: leftAnchor,bottom: bottomAnchor,paddingTop: 16,
                       paddingLeft: 16,paddingBottom: 16,paddingRight: 16)
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [button2,button3])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        addSubview(stack)
        stack.anchor(top: topAnchor,left:button1.rightAnchor,bottom: bottomAnchor,
                     right: rightAnchor,paddingTop: 16,paddingLeft: 16,paddingBottom: 16,
                     paddingRight: 16)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    @objc func handleSelectPhoto(sender:UIButton){
        delegate?.settingsHeader(self, didSelect: sender.tag)
    }
    
    func createButton(_ index:Int) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = index
        return button
    }
    
}

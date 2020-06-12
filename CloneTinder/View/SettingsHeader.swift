//
//  SettingsHeader.swift
//  CloneTinder
//
//  Created by David Murillo on 6/12/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

class SettingsHeader:UIView{
    //MARK: Properties
    var buttons = [UIButton]()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        
        let button1 = createButton()
        let button2 = createButton()
        let button3 = createButton()
        
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
    @objc func handleSelectPhoto(){
        print("Show photo selector")
    }
    
    func createButton() -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
}
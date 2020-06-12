//
//  HomeNavigationStackView.swift
//  TinderClone
//
//  Created by David Murillo on 6/8/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

protocol HomeNavigationStackViewDelegate:class{
    func showSettings()
    func showMessages()
}

class HomeNavigationStackView:UIStackView{
    
    weak var delegate:HomeNavigationStackViewDelegate?
     
    //MARK: - Properties
    let settingBtn = UIButton(type: .system)
    let messageBtn = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Height
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        
        settingBtn.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageBtn.setImage(#imageLiteral(resourceName: "top_messages_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingBtn,UIView(),tinderIcon,UIView(),messageBtn].forEach{ view in
            
            addArrangedSubview(view)
            
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingBtn.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
        messageBtn.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
        
    }
    
    @objc func handleShowSettings(){
        delegate?.showSettings()
    }
    
    @objc func handleShowMessages(){
        delegate?.showMessages()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  BottomControlsStackView.swift
//  TinderClone
//
//  Created by David Murillo on 6/8/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import Foundation
import UIKit

class BottomControlsStackView:UIStackView{
    //MARK: - Properties
    let refreshBtn = UIButton(type: .system)
    let disLikeBtn = UIButton(type: .system)
    let superLikeBtn = UIButton(type: .system)
    let likeBtn = UIButton(type: .system)
    let boostBtn = UIButton(type: .system)
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //height
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
        
        refreshBtn.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        disLikeBtn.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        superLikeBtn.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        likeBtn.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
       boostBtn.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [refreshBtn,disLikeBtn,superLikeBtn,likeBtn,boostBtn].forEach{ view in
            addArrangedSubview(view)
        }
        
      
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

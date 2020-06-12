//
//  CardView.swift
//  TinderClone
//
//  Created by David Murillo on 6/8/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

enum SwipeDirection:Int{
    case left = -1
    case right = 1
}

class CardView:UIView{
    
    
    //MARK: -Properties
    
    private let graidentLayer = CAGradientLayer()
    
    private let viewModel:CardViewModel
    
    private let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var infoLbl:UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.attributedText = viewModel.userInfoText
        
        return lbl
    }()
    
    private lazy var infoBtn:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    //MARK: LifeCycle
    
     init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configureGestureRecognizer()
        
        //imageView.image = viewModel.user.images.first
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        configureGraidentLayer()
        
        addSubview(infoLbl)
        infoLbl.anchor(left:leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingLeft: 16,paddingBottom: 16,paddingRight: 16)
        addSubview(infoBtn)
        infoBtn.setDimensions(height: 40, width: 40)
        infoBtn.centerY(inView: infoLbl)
        infoBtn.anchor(right:rightAnchor,paddingRight: 16)
            
        
    }
    
    override func layoutSubviews() {
         graidentLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    @objc func handlePanGesture(sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            superview?.subviews.forEach({$0.layer.removeAllAnimations()})
        case .changed:
          panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        @unknown default:
            break
        }
    }
    //When tapping the image it goes next index of the photo
    @objc func handleChangePhoto(sender:UITapGestureRecognizer){
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        if shouldShowNextPhoto{
            viewModel.showNextPhoto()
        }else{
            viewModel.showPreviousPhoto()
        }
        
        imageView.image = viewModel.imageToShow
    }
    
    //MARK: -Helper
    
    func panCard(sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: nil)
        let degrees:CGFloat = translation.x / 20
                  let angle = degrees * .pi / 180
                  let rotationalTransform = CGAffineTransform(rotationAngle: angle)
                  self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender:UIPanGestureRecognizer){
        let direction:SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard{
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }else{
                 self.transform = .identity
            }
           
        }) { (_) in
            //Switch
            if shouldDismissCard{
                self.removeFromSuperview()
            }  
        }
    }
  
    
    func configureGraidentLayer(){
        graidentLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        graidentLayer.locations = [0.5,1.1]
        layer.addSublayer(graidentLayer)
        
    }
    
    func configureGestureRecognizer(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
        
    }
    
}

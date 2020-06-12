//
//  HomeController.swift
//  TinderClone
//
//  Created by David Murillo on 6/7/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit
import Firebase

class HomeController:UIViewController{
    
    //MARK: -Properties
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    
    private var viewModels = [CardViewModel](){
        didSet {configureCards()}
    }
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        configUI()
        configureCards()
        fetchUsers()
        //logout()
    }
    
    //MARK: -API
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(withUid: uid) { (user) in
            print("My Account: \(user.email)")
        }
    }
    
    func fetchUsers(){
        Service.fetchUsers { (users) in
            self.viewModels = users.map({CardViewModel(user: $0)})
        }
    }
    
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser == nil{
            print("User not logged In")
            presentLoginController()
        }else{
            print("User is logged in")
        }
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
            presentLoginController()
        }catch{
            print("Failed to signout")
        }
    }
    
    //MARK: - Helper
    
    func configureCards(){
        viewModels.forEach { (viewModel) in
            let cardView = CardView(viewModel: viewModel)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        /*
        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "jane1"),#imageLiteral(resourceName: "jane3")])
        let user2 = User(name: "Megan", age: 21, images: [#imageLiteral(resourceName: "lady5c"),#imageLiteral(resourceName: "kelly1")])
          
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
  
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.fillSuperview()
        cardView2.fillSuperview()
        */
        
    }
    
    func configUI(){
        view.backgroundColor = .white
        
        topStack.delegate = self
        
        let stack = UIStackView(arrangedSubviews: [topStack,deckView,bottomStack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top:view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }
    
    func presentLoginController(){
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
}

extension HomeController:HomeNavigationStackViewDelegate{
    func showSettings() {
        let controller = SettingsController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func showMessages() {
        print("Messages")
    }
    
}

//
//  LoginController.swift
//  TinderClone
//
//  Created by David Murillo on 6/9/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

class LoginController:UIViewController{
    
    //MARK: Properties
    private var viewModel = LoginViewModel()
    
    private let iconImageView:UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
    }()
    
   private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTxtField = CustomTextField(placeholder: "Password", isSecureField: true)
    private let authButton:AuthButton = {
        let button = AuthButton(title: "Log In", type: .system)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let goToRegisrationButton:UIButton = {
        let button = UIButton(type: .system)
        let atrributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.foregroundColor:UIColor.white,.font:UIFont.systemFont(ofSize: 16)])
        atrributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.foregroundColor:UIColor.white,.font:UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(atrributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    
   
    override func viewDidLoad() {
    configureTextFieldObserver()
     configUI()
    }
    

     //MARK: Action
    @objc func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTxtField.text else {return}
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error{
                print("Error:\(error.localizedDescription)")
                return
            }
            
            print("Logged in user sucessful")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender:UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleShowRegistration(){
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    //MARK: -Helper
    
    func checkFormStatus(){
        if viewModel.formIsValid{
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }else{
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    func configUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 100, width: 100)
        iconImageView.anchor(top:view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTxtField,authButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top:iconImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 24,paddingLeft: 32,paddingRight: 32)
        view.addSubview(goToRegisrationButton)
        goToRegisrationButton.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
    }
    
    func configureTextFieldObserver(){
        emailTextField.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
    }
    
}

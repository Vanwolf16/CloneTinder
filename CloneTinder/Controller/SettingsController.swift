//
//  SettingsController.swift
//  CloneTinder
//
//  Created by David Murillo on 6/12/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import UIKit

class SettingsController:UITableViewController{
    //MARK: Properties
    private let headerView = SettingsHeader()
    private let imagePicker = UIImagePickerController()
    private var indexImage = 0
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Actions
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone(){
           print("Done")
       }
    
    //MARK: Helpers
    
    func setHeaderImage(_ image:UIImage?){
        headerView.buttons[indexImage].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func configureUI(){
        headerView.delegate = self
        imagePicker.delegate = self
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        
    }
    
    
}

extension SettingsController:SettingsHeaderDelegate{
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        self.indexImage = index
       present(imagePicker, animated: true, completion: nil)
    }
    
}

extension SettingsController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        
        //update the photo
        setHeaderImage(selectedImage)
        
        dismiss(animated: true, completion: nil)
    }
}

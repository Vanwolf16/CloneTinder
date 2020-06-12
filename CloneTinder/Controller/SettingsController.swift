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
    
    func configureUI(){
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

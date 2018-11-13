//
//  TableViewController.swift
//  SDKDemoSwift
//
//  Created by 王大吉 on 2/8/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var tableView: UITableView?
    
    var arrString = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView()
        tableView?.frame = view.frame
        tableView?.dataSource = self
        tableView?.delegate = self
        self.view.addSubview(tableView!)
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
//        tableView!.register(UITableViewCell.class, forCellReuseIdentifier: "UITableViewCell")

        // Do any additional setup after loading the view.
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrString.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = arrString[indexPath.row]
        return cell
    }

}

//
//  ViewController.swift
//  Brand List
//
//  Created by Damla Çim on 21.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ["Apple","Xiaomi","Samsung"]
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
        
    }
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        addBrand()
    }
    
    func addBrand() {
        let newBrand: String = "\(count). New Brand"
        count += 1
        dataSource.append(newBrand)
        let indexPath = IndexPath(row: dataSource.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }


}


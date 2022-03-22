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
        
        let alertController = UIAlertController(title: "Add Brand", message: "Enter the brand you want to add", preferredStyle: .alert) //alert oluşturdum
        
        alertController.addTextField(configurationHandler: { brandNameText in //text field oluşturduk
            brandNameText.placeholder = "Brand Name"
        })
        
        //buton oluşturdum addBrand fonksiyonunun new brand'ini alert içinden aldığım text field'a eşitledim
        
        let actionAdd = UIAlertAction(title: "Add", style: .default, handler: { action in
            let textFieldName = alertController.textFields![0] as UITextField
            self.addBrand(newBrand: textFieldName.text!)
        })
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionAdd)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func addBrand(newBrand: String) {
        //let newBrand: String = "\(count). New Brand"
        //count += 1
        dataSource.insert(newBrand, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
       
    }


}


//
//  ViewController.swift
//  Brand List
//
//  Created by Damla Çim on 21.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [String] = []
    var dataSourceDescp: [String] = []
    var selectedRow: Int = -1
    var brandDescp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
        //Edit Button
        let editButton = editButtonItem
        self.navigationItem.leftBarButtonItem = editButton
        
        loadData()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //ekran her önümüze geldiğinde bu fonksiyon çalışacak
        super.viewWillAppear(animated)
        
        if selectedRow == -1 {
            return
        }
        if brandDescp == "" {
            dataSourceDescp.remove(at: selectedRow)
            dataSource.remove(at: selectedRow)
        } else if brandDescp == dataSourceDescp[selectedRow] {
            return
        } else {
            dataSourceDescp[selectedRow] = brandDescp
        }
        saveData()
        tableView.reloadData()
    }
   
    
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        if tableView.isEditing == true {
            return
        }
    
        
        let alertController = UIAlertController(title: "Add Brand", message: "Enter the brand you want to add", preferredStyle: .alert) //alert oluşturdum
        
        alertController.addTextField(configurationHandler: { brandNameText in //text field oluşturduk
            brandNameText.placeholder = "Brand Name"
        })
        
        //buton oluşturdum addBrand fonksiyonunun new brand'ini alert içinden aldığım text field'a eşitledim
        
        let actionAdd = UIAlertAction(title: "Add", style: .default, handler: { action in
            let textFieldName = alertController.textFields![0] as UITextField
            self.addBrand(newBrand: textFieldName.text!)
        })
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //iptal butonu
        
        alertController.addAction(actionAdd) //alert'e eklediğim actionları belirtiyorum
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil) // alert'i kullanıcıya göster
        
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDescription", sender: self)
    }
  
    func addBrand(newBrand: String) {
        dataSource.insert(newBrand, at: 0)
        dataSourceDescp.insert("no data", at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        saveData()
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        performSegue(withIdentifier: "goToDescription", sender: self)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataSource.remove(at: indexPath.row) //silme işlemi yapıldığında dataSource'dan sil
            dataSourceDescp.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left) //tableview'dan sil
            saveData()
        }
        
    }
    
    func saveData() {
        UserDefaults.standard.set(dataSource, forKey: "brand")
        UserDefaults.standard.set(dataSourceDescp, forKey: "description")
    }
    
    func loadData() {
        if let loadData: [String] = UserDefaults.standard.value(forKey: "brand") as? [String] {
            dataSource = loadData
        }
        if let description: [String] = UserDefaults.standard.value(forKey: "description") as? [String] {
            dataSourceDescp = description
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let descriptionView: DescriptionViewController = segue.destination as! DescriptionViewController
        selectedRow = tableView.indexPathForSelectedRow!.row
        descriptionView.setDescription(text: dataSourceDescp[selectedRow])
        descriptionView.masterView = self
    }


}


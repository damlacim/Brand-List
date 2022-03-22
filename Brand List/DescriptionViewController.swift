//
//  DescriptionViewController.swift
//  Brand List
//
//  Created by Damla Çim on 22.03.2022.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UITextView!
    var descriptonText = ""
    
    var masterView: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = descriptonText
    }
    
    func setDescription(text: String) {
        descriptonText = text
        if isViewLoaded {
            descriptionLabel.text = descriptonText
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //bu ekrandan başka bir ekrana geçtiğimizde bu kod çalışır
        masterView?.brandDescp = descriptionLabel.text
    }
    

 

}

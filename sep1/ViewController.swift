//
//  ViewController.swift
//  sep1
//
//  Created by Richard de Jongh on 01/09/16.
//  Copyright © 2016 Richard de Jongh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Avatar: UIImageView!
    
    var person : Person?
    
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var streetValue: UILabel!
    @IBOutlet weak var cityValue: UILabel!
    @IBOutlet weak var zipValue: UILabel!
    @IBOutlet weak var stateValue: UILabel!
    @IBOutlet weak var phoneValue: UILabel!
    @IBOutlet weak var cellValue: UILabel!
    @IBOutlet weak var emailValue: UILabel!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Avatar.layer.borderColor = UIColor.black.cgColor
        Avatar.layer.borderWidth = 5.0
        Avatar.layer.cornerRadius = 75.0
        Avatar.clipsToBounds = true
        nameValue.text = (person?.firstName)! + " " + (person?.lastName)!
        emailValue.text = person?.email
        streetValue.text = person?.street
        cityValue.text = person?.city
        zipValue.text = person?.zip
        stateValue.text = person?.state
        phoneValue.text = person?.phone
        cellValue.text = person?.cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by Jayasri Gandi on 15/04/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var forgetPasswdLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet var viewCorners: [UIView]!
    
    var checkBoxStatus: [Bool] = [true, true, true, true]

    override func viewDidLoad() {
        super.viewDidLoad()
        
   

        // Do any additional setup after loading the view.
    }
    

    @IBAction func checkBoxTapped(_ sender: UIButton) {
    let currentStatus = checkBoxStatus[sender.tag-1]
        if currentStatus == true {
            sender.setImage(UIImage (named: "checkBox"), for: .normal)
        }else {
            sender.setImage(UIImage(named: "unCheckBox"), for: .normal)
        }
        checkBoxStatus[sender.tag - 1] = !currentStatus
        }
    
    @IBAction func backButtonTapped() {
        navigationController?.popViewController(animated: true)

    }

}

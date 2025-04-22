//
//  RegisterViewController.swift
//  MoviesApp
//
//  Created by Jayasri Gandi on 22/04/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerStackView : UIStackView!
    @IBOutlet weak var mobileStackView : UIStackView!
    @IBOutlet weak var emailTxtField : UITextField!
    @IBOutlet weak var emailPasswordTxtField : UITextField!
    @IBOutlet weak var MobileTxtField : UITextField!
    @IBOutlet weak var MobilePasswordTxtField : UITextField!
    @IBOutlet weak var signinWithFacebokk : UIView!
    @IBOutlet weak var signinWithTwitter : UIView!
    @IBOutlet weak var signinWithAppleID : UIView!
    @IBOutlet weak var emailTitleView : UIView!
    @IBOutlet weak var emailComponentsView : UIView!
    @IBOutlet weak var mobileTitleView : UIView!
    @IBOutlet weak var mobileComponentsView : UIView!
    @IBOutlet var checkBoxCollections:[UIButton]!
    @IBOutlet var termsCollections:[UILabel]!
    
    var checkBoxImageStatus: [Bool] = [true, true, true, true, true, true, true, true, true, true,true, true] // 11 items
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCornerradius()
        setUPTextFields()
        //       addUnderLine()
        
        for (index, button) in checkBoxCollections.enumerated() {
            button.tag = index + 1
        }
        
        
    }
    
    func addCornerradius() {
        registerStackView.layer.cornerRadius = 10.0
        registerStackView.layer.masksToBounds = true
        mobileStackView.layer.cornerRadius = 10.0
        mobileStackView.layer.masksToBounds = true
        signinWithFacebokk.layer.cornerRadius = 10.0
        signinWithTwitter.layer.cornerRadius = 10.0
        signinWithAppleID.layer.cornerRadius = 10.0
    }
    
    
    func setUPTextFields() {
        
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "E-mail ",attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        MobileTxtField.attributedPlaceholder = NSAttributedString(string: "Mobile",attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        emailPasswordTxtField.attributedPlaceholder = NSAttributedString(string: "Password ",attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        MobilePasswordTxtField.attributedPlaceholder = NSAttributedString(string: "Password ",attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
    }
    
    
    
    //    func addUnderLine() {
    //        let wholeStr = "I agree to the service terms of use and privacy policy."
    //        let privacyPolicy = "privacy policy"
    //        if let rangeToUnderline = wholeStr.range(of: privacyPolicy) {
    //            let nsRange = NSRange(rangeToUnderline, in: wholeStr)
    //
    //            let underLineTxt = NSMutableAttributedString(
    //                string: wholeStr,
    //                attributes: [
    //                    .font: UIFont.systemFont(ofSize: 20),
    //                    .foregroundColor: UIColor.lightGray
    //                ]
    //            )
    //            underLineTxt.addAttribute(
    //                .underlineStyle,
    //                value: NSUnderlineStyle.single.rawValue,
    //                range: nsRange
    //            )
    //            var style = NSMutableParagraphStyle()
    //            style.lineSpacing = 10
    //            underLineTxt.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: wholeStr.count))
    //
    //            for termLabel in termsCollections {
    //                termLabel.attributedText = underLineTxt
    //            }
    //        }
    //    }
    
    @IBAction func emailTapped() {
        if emailComponentsView.isHidden {
            emailComponentsView.isHidden = false
            emailTitleView.backgroundColor = UIColor(named: "appOrange")
            mobileComponentsView.isHidden = true
            mobileTitleView.backgroundColor = UIColor.darkGray
        }else {
            emailComponentsView.isHidden = true
            emailTitleView.backgroundColor = UIColor.darkGray
        }
    }
    
    @IBAction func mobileTapped() {
        if mobileComponentsView.isHidden {
            mobileComponentsView.isHidden = false
            mobileTitleView .backgroundColor = UIColor(named: "appOrange")
            emailComponentsView.isHidden = true
            emailTitleView.backgroundColor = UIColor.darkGray
        }else {
            mobileComponentsView.isHidden = true
            mobileTitleView.backgroundColor = UIColor.darkGray
        }
    }
    @IBAction func checkBoxTapped(sender: UIButton) {
        print(sender.tag)
        
        let currentStatus = checkBoxImageStatus[sender.tag - 1]
        
        if currentStatus == true {
            sender.setImage(UIImage(named: "check"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "Uncheck"), for: .normal)
        }
        
        checkBoxImageStatus[sender.tag - 1] = !currentStatus
    }
    
    @IBAction func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        
    }
}



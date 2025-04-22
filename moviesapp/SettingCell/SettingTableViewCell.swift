//
//  SettingTableViewCell.swift
//  MoviesApp
//
//  Created by Jayasri Gandi on 19/04/25.
//

import UIKit

protocol SettingTableViewCellDelegate {
    func loginButtontapped()
    func  RegisterButtontapped()
    func settingButtontapped()
}

class SettingTableViewCell: UITableViewCell {
    var delegate :SettingTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
            }
    
    @IBAction func loginButtontapped() {
        delegate.loginButtontapped()
     
    }
    
    @IBAction func  RegisterButtontapped() {
        delegate.RegisterButtontapped()
        
    }
    @IBAction func settingButtontapped() {
        delegate.settingButtontapped()
    }
    
}

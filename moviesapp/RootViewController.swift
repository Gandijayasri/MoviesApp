//
//  RootViewController.swift
//  MoviesApp
//
//  Created by Jayasri Gandi on 22/04/25.
//

import UIKit


class RootViewController: UIViewController {
 
    @IBOutlet weak var homeView:UIView!
    @IBOutlet weak var homeViewWidth:NSLayoutConstraint!
    @IBOutlet weak var menuView:UIView!
    @IBOutlet weak var menuViewLeading:NSLayoutConstraint!
    @IBOutlet weak var menuTableView:UITableView!
    @IBOutlet weak var menuWidth:NSLayoutConstraint!
    @IBOutlet weak var hometableView:UITableView!
    @IBOutlet weak var homeTitle:UILabel!
    
    var isSidemenuOpen = false
    var menuData:[Menu] = []
    var homeData:[Playlist] = []
    var titleText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewWidth.constant = screenWidth
        menuWidth.constant = menuViewWidth
        menuViewLeading.constant = -menuViewWidth
        menuTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        menuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        hometableView.register(UINib(nibName: "CarousalTableViewCell", bundle: nil), forCellReuseIdentifier: "CarousalTableViewCell")
        hometableView.delegate = self
        hometableView.dataSource = self
        
    
        getMenuData()
        getHomeData(homeID: "62")
        
        
           }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideSideMenu()
    }
    
    func hideSideMenu() {
        menuViewLeading.constant = -menuViewWidth
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
        isSidemenuOpen = false
    }


    
    @IBAction func menuTapped() {
        print("Menu tapped, current state: \(isSidemenuOpen)")
        if isSidemenuOpen {
            menuViewLeading.constant = -menuViewWidth
            
            print("Closing menu, setting leading constraint to -280")
            UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            } completion: { bool in
                self.isSidemenuOpen = false
                print("Menu closed animation completed")
            }
        }else {
            menuViewLeading.constant = 0
            print("Opening menu, setting leading constraint to 0")
            UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            } completion: { bool in
                self.isSidemenuOpen = true
                print("Menu opened animation completed")
            }
        }
    }
    
    func getMenuData() {
        guard let url = URL(string: "https://dummyjson.com/c/1f15-18a9-4858-913b")
        else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        var headers: [String: String] = [:]
        headers ["Authorization"] = "cf606825b8a045c1aae39f7fe39de7d7"
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let menuModel = try? JSONDecoder().decode (MenuModel.self, from:data)
                self.menuData = menuModel?.body?.data ?? []
                DispatchQueue.main.sync {
                    self.menuTableView.reloadData()
                }
                
                print ("menucount",menuModel?.body?.data?.count ?? 0)
            }
        }.resume ()
    }
    
    func getHomeData(homeID:String) {
        guard let url = URL(string: "https://dummyjson.com/c/01ff-5c0c-4d12-a864")
        else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        var headers: [String: String] = [:]
        headers ["Authorization"] = "cf606825b8a045c1aae39f7fe39de7d7"
        headers ["Content-Type"] = "application/json"
        urlRequest.allHTTPHeaderFields = headers
        
        let body: [String: Any] = ["homeid": "62"]
        if let bodyData = try? JSONSerialization.data(withJSONObject: body,options: .prettyPrinted) {
            
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                if let  homeModel = try? JSONDecoder().decode(HomeModel.self,from: data) {
                    print("HomeModel:",homeModel.response?.data?.playlists?.count ?? "")
                    self.homeData = homeModel.response?.data?.playlists ?? []
                    self.titleText = homeModel.response?.data?.title ?? ""
                    
                    
                    DispatchQueue.main.async {
                        self.homeTitle.text = self.titleText
                        self.hometableView.reloadData()
                    }
                }
            }
        }.resume ()
    }
    }



extension RootViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == hometableView{
            return 2
        }else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == hometableView{
            if section == 0 {
                return 1
            }else  {
                return menuData.count
            }
        }else {
            return homeData.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hometableView {
            if indexPath.section == 0 {
                if let cell = menuTableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell" , for: indexPath) as? SettingTableViewCell {
                    cell.delegate = self
                    return cell
                    
                }else if indexPath.section == 1 {
                    if let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell{
                        cell.confiqureUI(menu: menuData[indexPath.row])
                        return cell
                        
                    }
                }
            }
            
        }else {
            if let cell = hometableView.dequeueReusableCell(withIdentifier: "CarousalTableViewCell", for: indexPath) as? CarousalTableViewCell{
                cell.configureUI(playlist: homeData[indexPath.row])
                
                 return cell
            }
        }
       
        return UITableViewCell()
    }
}

extension RootViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == hometableView {
            if indexPath.section == 0 {
                return 60
            } else {
                return 45
            }
        }else {
            return 250
        }
    }

}
extension RootViewController: SettingTableViewCellDelegate{
    func loginButtontapped() {
        print ("loginButtontapped")
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(controller, animated: true)
        self.isSidemenuOpen = false
    }
    
    func RegisterButtontapped() {
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.pushViewController(controller, animated: true)
        self.isSidemenuOpen = false
    }
    
    func settingButtontapped() {
        print ("settingButtontapped")
    }
   
}



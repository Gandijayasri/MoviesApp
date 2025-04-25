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
    
    var isSidemenuOpen = false
    var menuData:[Menu] = []
    private var shouldScrollToTop = false
    var homeData: [Playlist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup menu table view
        homeViewWidth.constant = screenWidth
        menuWidth.constant = menuViewWidth
        menuViewLeading.constant = -menuViewWidth
        menuTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        menuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        // Setup home table view
        hometableView.delegate = self
        hometableView.dataSource = self
        hometableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCell")
        
        // Load data
        getHomeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideSideMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMenuData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if shouldScrollToTop && !homeData.isEmpty {
            shouldScrollToTop = false
            let indexPath = IndexPath(row: 0, section: 0)
            if hometableView.numberOfRows(inSection: 0) > 0 {
                hometableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
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
        guard let url = URL(string: "https://jwxebkwcfj.execute-api.us-east-1.amazonaws.com/dev/menu")
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
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                }
                print ("menucount",menuModel?.body?.data?.count)
            }
        }.resume ()
    }
    
    func getHomeData() {
        guard let url = URL(string: "https://dummyjson.com/c/01ff-5c0c-4d12-a864")
        else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        var headers: [String: String] = [:]
        headers["Authorization"] = "cf606825b8a045c1aae39f7fe39de7d7"
        headers["Content-Type"] = "application/json"
        urlRequest.allHTTPHeaderFields = headers
        
        let body: [String: Any] = ["homeid": "62"]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            urlRequest.httpBody = bodyData
            
            URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let data = data {
                    if let homeModel = try? JSONDecoder().decode(HomeModel.self, from: data) {
                        print("HomeModel:", homeModel.response?.data?.playlists?.count ?? "")
                        self.homeData = homeModel.response?.data?.playlists ?? []
                        
                        DispatchQueue.main.async {
                            self.hometableView.reloadData()
                        }
                    }
                }
            }.resume()
        } catch {
            print("Error serializing JSON: \(error)")
        }
    }
    
    func scrollToFirstRow() {
        guard menuData.count > 0 else { return }
        let indexPath = IndexPath(row: 0, section: 1)
        if menuTableView.numberOfRows(inSection: 1) > 0 {
            menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    private func setupTableView() {
        hometableView.delegate = self
        hometableView.dataSource = self
        hometableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCell")
        hometableView.reloadData()
    }
}


extension RootViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == menuTableView {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return section == 0 ? 1 : menuData.count
        }
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menuTableView {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
                // Configure menu cell if needed
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
            // Configure home cell
            cell.textLabel?.text = "Home Item \(indexPath.row)"
            return cell
        }
    }
}

extension RootViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == menuTableView {
            return indexPath.section == 0 ? 60 : 45
        }
        return 100 // Height for home table view cells
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            scrollToFirstRow()
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



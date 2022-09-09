//
//  ListOfFlowers.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit

class ListOfFlowers: UIViewController{
    
    let tableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let listOfFlowersCellId = "listOfFlowersCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerConfig()
        setConstraints()
        
    }
    
    private func viewControllerConfig(){
        
        title = "Мои Цветы"
        view.backgroundColor = UIColor(hexString: "#FBDDE7")
        navigationController?.tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#CA587F")
        
        if #available(iOS 13.0, *) {
                            let navBarAppearance = UINavigationBarAppearance()
                            navBarAppearance.configureWithOpaqueBackground()
                            navBarAppearance.backgroundColor = UIColor(hexString: "#CA587F")
                    navBarAppearance.largeTitleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
                    ]
                    navBarAppearance.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
                    ]
                    navigationController?.navigationBar.standardAppearance = navBarAppearance
                    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                    navigationController?.navigationBar.tintColor = UIColor(hexString: "#ECFBDE")
                        } else {
                            navigationController?.navigationBar.barTintColor = UIColor(hexString: "#ECFBDE")
                        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#FBDDE7")
        tableView.separatorStyle = .none
        tableView.register(ListOfFlowersCell.self, forCellReuseIdentifier: listOfFlowersCellId)
        
    }
    
    private  func setConstraints(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ListOfFlowers: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listOfFlowersCellId, for: indexPath) as! ListOfFlowersCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

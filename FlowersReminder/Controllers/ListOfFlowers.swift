//
//  ListOfFlowers.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit
import RealmSwift

class ListOfFlowers: UIViewController{
    
    let localRealm = try! Realm()
    var flowerModel: Results<FlowerModel>!
    
    let tableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let listOfFlowersCellId = "listOfFlowersCellId"
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        viewControllerConfig()
        setConstraints()
        flowerModel = localRealm.objects(FlowerModel.self)
        
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToAddNewFlower))
        
    }
    
    @objc func pushToAddNewFlower(){
        let addNewFlower = AddNewFlower()
        navigationController?.pushViewController(addNewFlower, animated: true)
    }
    
    //MARK: setConstraints
    
    private  func setConstraints(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    //MARK: changeDate logic
    
    private func changeDay(){
        
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ListOfFlowers: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowerModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listOfFlowersCellId, for: indexPath) as! ListOfFlowersCell
        cell.cellConfig(indexPath: indexPath, model: flowerModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flowerCard = FlowerCard()
        flowerCard.flowerModel = flowerModel[indexPath.row]
        navigationController?.pushViewController(flowerCard, animated: true)
    }
}

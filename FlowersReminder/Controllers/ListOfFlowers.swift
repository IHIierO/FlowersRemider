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
    
    fileprivate let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ListOfFlowerCVCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    var search = false
    
    override func viewWillAppear(_ animated: Bool) {
//        if #available(iOS 13.0, *) {
//                            let navBarAppearance = UINavigationBarAppearance()
//                            navBarAppearance.configureWithOpaqueBackground()
//                            navBarAppearance.backgroundColor = UIColor(hexString: "#CA587F")
//                    navBarAppearance.largeTitleTextAttributes = [
//                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
//                    ]
//                    navBarAppearance.titleTextAttributes = [
//                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
//                    ]
//                    navigationController?.navigationBar.standardAppearance = navBarAppearance
//                    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//                    navigationController?.navigationBar.tintColor = UIColor(hexString: "#ECFBDE")
//                        } else {
//                            navigationController?.navigationBar.barTintColor = UIColor(hexString: "#ECFBDE")
//                        }
        
        let tabBar = self.tabBarController as! TabBar
        tabBar.showTabBar()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
        viewControllerConfig()
        setConstraints()
        flowerModel = localRealm.objects(FlowerModel.self)
        changeDay()
    }
    
    private func viewControllerConfig(){
        
        title = "Мои Цветы"
        view.backgroundColor = .white // UIColor(hexString: "#FBDDE7")
        
//        navigationController?.tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#CA587F")
        
//        if #available(iOS 13.0, *) {
//                            let navBarAppearance = UINavigationBarAppearance()
//                            navBarAppearance.configureWithOpaqueBackground()
//                            navBarAppearance.backgroundColor = UIColor(hexString: "#CA587F")
//                    navBarAppearance.largeTitleTextAttributes = [
//                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
//                    ]
//                    navBarAppearance.titleTextAttributes = [
//                        NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FBDDE7")
//                    ]
//                    navigationController?.navigationBar.standardAppearance = navBarAppearance
//                    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//                    navigationController?.navigationBar.tintColor = UIColor(hexString: "#ECFBDE")
//                        } else {
//                            navigationController?.navigationBar.barTintColor = UIColor(hexString: "#ECFBDE")
//                        }
       
        collectionView.delegate = self
        collectionView.dataSource = self

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    //MARK: setConstraints
    
    private  func setConstraints(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    //MARK: changeDate logic
    
    private func changeDay(){
        
        for flower in flowerModel{
            let today = Date()
            let verificationDay: Date = {
                let components = DateComponents(day: -1)
                return Calendar.current.date(byAdding: components, to: today)!
            }()
            
            let irrigationDay = DateComponents(day: flower.irrigationFrequency)
            let fertilizerDay = DateComponents(day: flower.fertilizerFrequency)
            
            
            if flower.compliteColor == "#9f9f9f" && Calendar.current.isDate(flower.dateWatering, equalTo: verificationDay, toGranularity: .day){
                try! localRealm.write{
                    flower.dateWatering = Calendar.current.date(byAdding: irrigationDay, to: flower.dateWatering)!
                    flower.dateFertilizer = Calendar.current.date(byAdding: fertilizerDay, to: flower.dateFertilizer)!
                    flower.compliteColor = "#000000"
                }
            }
            if flower.compliteColor == "#000000" && Calendar.current.isDate(flower.dateWatering, equalTo: verificationDay, toGranularity: .day){
                try! localRealm.write{
                    flower.dateWatering = Calendar.current.date(byAdding: .init(day: 1), to: flower.dateWatering)!
                    flower.dateFertilizer = Calendar.current.date(byAdding: .init(day: 1), to: flower.dateFertilizer)!
                }
            }
            if flower.dateFertilizer < flower.dateWatering{
                try! localRealm.write{
                    flower.dateFertilizer = flower.dateWatering
                }
            }
        }
    }
}

//MARK: UICollectionViewFlowLayout, UICollectionViewDataSource
extension ListOfFlowers: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if search{
            let searchText = searchController.searchBar.text!
            
            return flowerModel.filter("flowerName CONTAINS[cd] %@", searchText).count
        }else{
            return flowerModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListOfFlowerCVCell
        
        if search{
            let searchText = searchController.searchBar.text!
            let model = flowerModel.filter("flowerName CONTAINS[cd] %@", searchText)[indexPath.row]
            cell.cellConfig(indexPath: indexPath, model: model)
        }else{
            cell.cellConfig(indexPath: indexPath, model: flowerModel[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flowerCard = FlowerCard(collectionViewLayout: FlowerCardHeaderLayout())
        
        if search{
            let searchText = searchController.searchBar.text!
            let searchFlower = flowerModel.filter("flowerName CONTAINS[cd] %@", searchText)[indexPath.row]
            flowerCard.flowerModel = searchFlower
        }else{
            flowerCard.flowerModel = flowerModel[indexPath.row]
        }
        navigationController?.pushViewController(flowerCard, animated: true)
    }
    
}

//MARK: UISearchBarDelegate, UISearchResultsUpdating
extension ListOfFlowers: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty{
            search = true
        }else{
            search = false
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        search = false
        collectionView.reloadData()
    }
}

//
//  AddNewFlower.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit
import RealmSwift

class AddNewFlower: UIViewController {

    let flowersImage: UIImageView = {
        let flowersImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        flowersImage.image = UIImage(named: "defaultFlower")
        flowersImage.contentMode = .scaleAspectFill
        flowersImage.clipsToBounds = true
        flowersImage.translatesAutoresizingMaskIntoConstraints = false
        return flowersImage
    }()
 
    let flowerName: UITextView = {
        let flowerName = UITextView()
        flowerName.text = "Название Цветка"
        flowerName.textColor = .lightGray
        flowerName.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        flowerName.textAlignment = .left
        flowerName.layer.borderWidth = 1
        flowerName.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        flowerName.layer.cornerRadius = 5
        flowerName.sizeToFit()
        flowerName.isScrollEnabled = false
         
        flowerName.translatesAutoresizingMaskIntoConstraints = false
        return flowerName
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let addImageButton: UIButton = {
        let addImageButton = UIButton()
        addImageButton.setTitle("Добавить Фото", for: .normal)
        addImageButton.titleLabel?.font = .systemFont(ofSize: 13)
        addImageButton.setTitleColor(.systemBlue, for: .normal)
        
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        return addImageButton
    }()
    
    var dataStrings: [String] = [String]()
    
    let idAddNewFlowerCell = "idAddNewFlowerCell"
    
    private var flowerModel = FlowerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        dataStrings = ["","","","",""]
        
        view.backgroundColor = UIColor(hexString: "#FBDDE7")
//        title = "Добавить Цветок"
        
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
        
        flowersImage.layer.borderWidth = 1
        flowersImage.layer.cornerRadius = 10
        
        addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        
        flowerName.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hexString: "#FBDDE7")
        tableView.register(AddNewFlowerCell.self, forCellReuseIdentifier: idAddNewFlowerCell)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
                let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
         }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: { self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)})
    }
                                                                                      
    @objc func addImageButtonTapped(){
            ImagePickerManager().pickImage(self){ image in self.flowersImage.image = image}
        }
                                                                                          
    @objc func saveButtonTapped(){
        
        let dataImage = NSData(data: flowersImage.image!.jpegData(compressionQuality: 0.7)!)

        self.flowerModel.flowerImage = dataImage as Data
        self.flowerModel.flowerName = flowerName.text
        self.flowerModel.temperature = dataStrings[0]
        self.flowerModel.sun = dataStrings[1]
        self.flowerModel.watering = dataStrings[2]
        self.flowerModel.fertilization = dataStrings[3]
        self.flowerModel.toxicityForAnimals = dataStrings[4]

        RealmManager.shared.saveFlowerModel(model: flowerModel)

        flowerModel = FlowerModel()
        
        saveAlert(tableView: tableView, flowerName: flowerName, flowerImage: flowersImage)
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        tableView.reloadData()
    }

    //MARK: setConstraints
    func setConstraints(){
        view.addSubview(flowersImage)
        NSLayoutConstraint.activate([
            flowersImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            flowersImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            flowersImage.widthAnchor.constraint(equalToConstant: 100),
            flowersImage.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        view.addSubview(addImageButton)
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: flowersImage.bottomAnchor, constant: 2),
            addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
        ])

        view.addSubview(flowerName)
        NSLayoutConstraint.activate([
            flowerName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            flowerName.leadingAnchor.constraint(equalTo: flowersImage.trailingAnchor, constant: 10),
            flowerName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: TableViewDelegate, TableViewDataSource
extension AddNewFlower: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddNewFlowerCell, for: indexPath) as! AddNewFlowerCell
        cell.cellConfig(indexPath: indexPath)
        cell.flowerInfo.text = dataStrings[indexPath.row]
        cell.callback = { string in
            self.dataStrings[indexPath.row] = string
                }
        
        if dataStrings[4] != ""{
            navigationItem.rightBarButtonItem?.isEnabled = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: UITextViewDelegate
extension AddNewFlower: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if flowerName.textColor == .lightGray{
            flowerName.text = nil
            flowerName.textColor = .black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if flowerName.text.isEmpty{
            flowerName.text = "Название Цветка"
            flowerName.textColor = .lightGray

        }else{

        }
    }
}

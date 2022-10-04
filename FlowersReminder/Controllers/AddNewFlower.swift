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
        addImageButton.setTitleColor(UIColor(hexString: "#393C39"), for: .normal)
        addImageButton.titleLabel?.font = .systemFont(ofSize: 13)
        
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        return addImageButton
    }()
    
    let idAddNewFlowerCell = "idAddNewFlowerCell"
    
    private var flowerModel = FlowerModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        viewControllerConfig()
        view.backgroundColor = .white
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
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.reloadData()
        flowerName.text = "Название Цветка"
        flowerName.textColor = .lightGray
        flowersImage.image = UIImage(named: "defaultFlower")
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func viewControllerConfig(){
        flowersImage.layer.borderWidth = 1
        flowersImage.layer.cornerRadius = 10
        
        addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        
        flowerName.delegate = self
        flowerName.addDoneButton(title: "Готово", target: self, selector: #selector(tapDone(sender: )))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white //UIColor(hexString: "#FBDDE7")
        tableView.register(AddNewFlowerCell.self, forCellReuseIdentifier: idAddNewFlowerCell)
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    
    @objc func addImageButtonTapped(){
            ImagePickerManager().pickImage(self){ image in self.flowersImage.image = image}
        }
                                                                                          
    @objc func saveButtonTapped(){
        
        let dataImage = NSData(data: flowersImage.image!.jpegData(compressionQuality: 0.7)!)

        self.flowerModel.flowerImage = dataImage as Data
        self.flowerModel.flowerName = flowerName.text
        RealmManager.shared.saveFlowerModel(model: flowerModel)
        flowerModel = FlowerModel()
        saveAlert(tableView: tableView, flowerName: flowerName, flowerImage: flowersImage)
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
            tableView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: TableViewDelegate, TableViewDataSource
extension AddNewFlower: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddNewFlowerCell, for: indexPath) as! AddNewFlowerCell
        cell.cellConfig(indexPath: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! AddNewFlowerCell
        switch indexPath {
        case [0,0]:
            alertDatePicker(label: cell.flowerInfo) { (date) in
                self.flowerModel.dateWatering = date
                self.flowerModel.dateFertilizer = date
            }
        case [0,1]:
            temperaturePicker(label: cell.flowerInfo) { String in
                self.flowerModel.temperature = String
            }
        case [0,2]:
            sunPicker(label: cell.flowerInfo) { String in
                self.flowerModel.sun = String
            }
        case [0,3]:
            alertIrrigationFrequencyPicker(label: cell.flowerInfo) { [self]  String in
                
                    if String == "Раз в 3 дня"{
                        flowerModel.irrigationFrequency = 3
                    }else if String ==  "Раз в 5 дней"{
                        flowerModel.irrigationFrequency = 5
                    }else if String ==  "Раз в неделю"{
                        flowerModel.irrigationFrequency = 7
                    }else if String ==  "Раз в 2 недели"{
                        flowerModel.irrigationFrequency = 14
                    }else if String ==  "Раз в месяц"{
                        flowerModel.irrigationFrequency = 30
                    }else if String ==  "Раз в два месяца"{
                        flowerModel.irrigationFrequency = 61
                    }
            }
        case [0,4]:
            alertFertilizerFrequencyPicker(label: cell.flowerInfo) { [self] String in
               
                    if String == "Раз в месяц"{
                        flowerModel.fertilizerFrequency = 30
                    }else if String ==  "Раз в 2 месяца"{
                        flowerModel.fertilizerFrequency = 61
                    }
            }
        case [0,5]:
            toxicityForAnimalsPicker(label: cell.flowerInfo) { String in
                if String != "Токсичен / Не токсичен для животных"{
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
                self.flowerModel.toxicityForAnimals = String
            }
        default:
            print("Error")
        }
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
        }
    }

}

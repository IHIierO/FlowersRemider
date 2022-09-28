//
//  ActiveAlarms.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit
import FSCalendar
import RealmSwift
import UserNotifications

class ActiveAlarms: UIViewController{
    
    let localRealm = try! Realm()
    var flowerModel: Results<FlowerModel>!
    
    var calendarHeightConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
       let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let openCalendarButton: UIButton = {
        let openCalendarButton = UIButton()
        openCalendarButton.setTitle("Открыть календарь", for: .normal)
        openCalendarButton.setTitleColor(.black, for: .normal)
        openCalendarButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        openCalendarButton.translatesAutoresizingMaskIntoConstraints = false
        return openCalendarButton
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let activeAlarmsCellId = "activeAlarmsCellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfig()
        alarmOnDay(date: calendar.today!)
        
    }
    
    private func viewControllerConfig(){
        title = "Будильники"
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
        
        setConstraints()
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        calendar.firstWeekday = 2
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        openCalendarButton.addTarget(self, action: #selector(openCalendarButtonTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white // UIColor(hexString: "#FBDDE7")
        tableView.register(ActiveAlarmsCell.self, forCellReuseIdentifier: activeAlarmsCellId)
        tableView.separatorStyle = .none
        
    }
    
    @objc func openCalendarButtonTapped(){
        if calendar.scope == .week{
            calendar.scope = .month
            openCalendarButton.setTitle("Закрыть календарь", for: .normal)
        }else{
            calendar.scope = .week
            openCalendarButton.setTitle("Открыть календарь", for: .normal)
        }
    }
    
    private func alarmOnDay(date: Date){
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let dateWateringPredicate = NSPredicate(format: "dateWatering BETWEEN %@", [dateStart, dateEnd])
        let datedFertilizerPredicate = NSPredicate(format: "dateFertilizer BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [dateWateringPredicate, datedFertilizerPredicate])
        
        flowerModel = localRealm.objects(FlowerModel.self).filter(compound)
        
        if !flowerModel.isEmpty {
            notificationOnDay()
           
        }
        
        tableView.reloadData()
        
    }
    
    func notificationOnDay(){
        let content = UNMutableNotificationContent()
        content.title = "Не забудь полить цветы"
        content.body = "Сегодня есть цветы, которые нужно полить"
        content.sound = .default
        content.categoryIdentifier = "notificationOnDay"
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 56
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest.init(identifier: "notificationOnDay", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}

extension ActiveAlarms: FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource, TapButtonProtocol {
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowerModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: activeAlarmsCellId, for: indexPath) as! ActiveAlarmsCell
        cell.activeAlarmsCellDelegate = self
        cell.cellConfig(indexPath: indexPath, model: flowerModel[indexPath.row],date: calendar.selectedDate ?? calendar.today!)
        cell.indexPath = indexPath
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //MARK: compliteButtonTapped
    
    func buttonTapped(indexPath: IndexPath) {
        if flowerModel[indexPath.row].compliteColor == "#000000"{
            RealmManager.shared.updateCompliteColor(model: flowerModel[indexPath.row], hex: "#9f9f9f")
        }else if flowerModel[indexPath.row].compliteColor == "#9f9f9f"{
            RealmManager.shared.updateCompliteColor(model: flowerModel[indexPath.row], hex: "#000000")
        }
        tableView.reloadData()
    }
    
    //MARK: FSCalendar delegate and dataSource
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        alarmOnDay(date: date)
    }
    
    //MARK: Set constraints
    
    func setConstraints(){
        view.addSubview(calendar)
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        calendar.addConstraint(calendarHeightConstraint)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        view.addSubview(openCalendarButton)
        NSLayoutConstraint.activate([
            openCalendarButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 5),
            openCalendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            openCalendarButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: openCalendarButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}

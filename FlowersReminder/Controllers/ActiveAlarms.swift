//
//  ActiveAlarms.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 06.09.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class ActiveAlarms: UIViewController{
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfig()
        
    }
    
    private func viewControllerConfig(){
        title = "Будильники"
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
        
        setConstraints()
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        calendar.firstWeekday = 2
        openCalendarButton.addTarget(self, action: #selector(openCalendarButtonTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hexString: "#FBDDE7")
        tableView.register(ActiveAlarmsCell.self, forCellReuseIdentifier: activeAlarmsCellId)
        
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
}


extension ActiveAlarms: FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource, TapCompliteButtonProtocol {
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: activeAlarmsCellId, for: indexPath) as! ActiveAlarmsCell
        cell.activeAlarmsCellDelegate = self
        cell.indexPath = indexPath
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //MARK: compliteButtonTapped
    
    func compliteButtonTapped(indexPath: IndexPath) {
        print("tap")
    }
    
    //MARK: FSCalendar delegate and dataSource
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
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

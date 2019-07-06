//
//  SettingsViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 04/07/2019.
//

import UIKit
import FirebaseAuth

enum SectionHeader: String, CaseIterable {
    
    case account = "ACCOUNT"
    case userSettings = "USER SETTINGS"
    
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(SettingsViewController.refresh), for: UIControl.Event.valueChanged)
//        tableView.refreshControl = refreshControl
        
//        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            UIUtils.showError(message: error.localizedDescription)
        }
        UIUtils.switchToLoginController()
    }
    
    
}

extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionHeader.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionHeader.allCases[indexPath.section] {
        case SectionHeader.account:
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell()
                let cellLabel = UILabel()
                cellLabel.text = "Logout"
                return cell
            case 1:
                return UITableViewCell()
            default:
                return UITableViewCell()
            }
        case SectionHeader.userSettings:
            return UITableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UILabel()
        sectionHeaderView.backgroundColor = UIColor.lightGray
        
        switch SectionHeader.allCases[section] {
        case SectionHeader.account:
            sectionHeaderView.text = SectionHeader.account.rawValue
        case SectionHeader.userSettings:
            sectionHeaderView.text = SectionHeader.userSettings.rawValue
        }
        
        sectionHeaderView.font = UIFont.systemFont(ofSize: 12)

        return sectionHeaderView
    }
    
}

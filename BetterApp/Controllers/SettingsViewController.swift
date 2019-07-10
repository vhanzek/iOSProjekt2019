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
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func logoutTapped() {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            UIUtils.showError(message: error.localizedDescription)
        }
        UIUtils.switchToLoginController()
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionHeader.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch SectionHeader.allCases[indexPath.section] {
        case SectionHeader.account:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Logout"
                return cell
            case 1:
                cell.textLabel?.text = "Delete account"
                return cell
            default:
                return cell
            }
        case SectionHeader.userSettings:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Change password"
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                cell.textLabel?.text = "Change e-mail"
                cell.accessoryType = .disclosureIndicator
                return cell
            default:
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch SectionHeader.allCases[indexPath.section] {
        case SectionHeader.account:
            switch indexPath.row {
            case 0:
                logoutTapped()
            case 1:
                UIUtils.showYesCancelAlert(title: "Delete account", message: "Are you sure you want to delete your account?") {
                    UserService().deleteAccount()
                }
            default:
                break
            }
        case SectionHeader.userSettings:
            switch indexPath.row {
            case 0:
                UIUtils.showChangeFieldDialog(field: "password")
            case 1:
                UIUtils.showChangeFieldDialog(field: "e-mail")
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UILabel()
        sectionHeaderView.backgroundColor = .white
        
        switch SectionHeader.allCases[section] {
        case SectionHeader.account:
            sectionHeaderView.text = SectionHeader.account.rawValue
        case SectionHeader.userSettings:
            sectionHeaderView.text = SectionHeader.userSettings.rawValue
        }
        
        sectionHeaderView.textAlignment = .center
        sectionHeaderView.textColor = UIUtils.colorVistaBlue
        sectionHeaderView.font = UIFont.boldSystemFont(ofSize: 12)

        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}

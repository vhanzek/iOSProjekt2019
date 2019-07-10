//
//  HomeViewController.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 01/07/2019.
//

import UIKit

class HabitsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: HabitsViewModel!
    
    private let cellReuseIdentifier = "cellReuseIdentifier"
    private var refreshControl: UIRefreshControl!
    
    private let showAll = true
    
    convenience init(viewModel: HabitsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatabase()
        setupNavigationBar()
        setupTableView()
    }
    
    func updateData() {
        Spinner.start()
        self.viewModel!.fetchHabits {
            self.refresh()
            Spinner.stop()
        }
    }
    
    private func setupDatabase() {
        // Fetch habits from server
        updateData()
        
        // Observe habits
        FirebaseManager.shared.getCurrentUserHabitsReference().observe(.childChanged, with: { (snapshot) -> Void in
            DispatchQueue.main.async {
                self.updateData()
            }
        })
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Habits"
        self.navigationController?.navigationBar.barTintColor = UIUtils.colorVistaBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"settings"), style: .plain, target: self, action: #selector(settingsTapped))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HabitsViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "HabitTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func addHabitTapped() {
        let newHabitViewController = NewHabitViewController()
        self.navigationController?.pushViewController(newHabitViewController, animated: true)
    }
    
    @objc func settingsTapped() {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}

extension HabitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let category = Category.allCases[section]
//        return QuizzesTableSectionHeader(title: category.rawValue, color: category.color)
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return showAll ? "" : viewModel!.currentCategories[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let habitViewModel = self.viewModel!.habitViewModel(forIndexPath: indexPath, showAll: showAll) {
            let habitViewController = HabitViewController(viewModel: habitViewModel)
            navigationController?.pushViewController(habitViewController, animated: true)
        }
    }
    
}

extension HabitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showAll ? viewModel!.numberOfHabits() : viewModel!.numberOfHabits(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return Category.allCases.count
        return showAll ? 1 : viewModel!.currentCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! HabitTableViewCell
        
        if let habit = self.viewModel!.habit(forIndexPath: indexPath, showAll: showAll) {
            cell.setup(withHabit: habit)
            cell.delegate = self
        }
        return cell
    }
}

extension HabitsViewController: HabitTableViewCellDelegate {
    
    func deleteClicked(forHabit id: String) {
        UIUtils.showYesCancelAlert(title: "Delete habit",
                                   message: "Are you sure you want to delete this habit?") {
            Spinner.start()
            self.viewModel.deleteHabit(forHabit: id) {
                self.updateData()
                Spinner.stop()
            }
        }
        
    }
    
}
    

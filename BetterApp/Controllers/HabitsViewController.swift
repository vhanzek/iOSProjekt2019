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
    
    convenience init(viewModel: HabitsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupNavigationBar()
        setupTableView()
    }
    
    private func fetchData() {
        //        viewModel!.fetchHabits {
        //            self.refresh()
        //        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Habits"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"settings"), style: .plain, target: self, action: #selector(settingsTapped))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HabitsViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
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
        return 104.0
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let category = Category.allCases[section]
//        return QuizzesTableSectionHeader(title: category.rawValue, color: category.color)
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if let quizViewModel = self.viewModel!.quizViewModel(forIndexPath: indexPath) {
//            let quizViewController = QuizViewController(viewModel: quizViewModel)
//            navigationController?.pushViewController(quizViewController, animated: true)
//        }
    }
    
}

extension HabitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let category = Category.allCases[section]
        //return self.viewModel!.numberOfQuizzes(category: category)
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return Category.allCases.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizTableViewCell
//
//        if let quiz = self.viewModel!.quiz(forIndexPath: indexPath) {
//            cell.setup(withQuiz: quiz)
//            cell.delegate = self
//        }
//        return cell
        return UITableViewCell()
    }
}
    

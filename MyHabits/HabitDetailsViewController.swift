
import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habitName: String?
    var currentHabit: Habit?
    let store = HabitsStore.shared
    //static var count = 0
    
    fileprivate enum CellReuseIdentifiers: String {
        case tracking = "TrackingCellReuse"
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.toAutoLayout()
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.tracking.rawValue)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(tableView)
        setupConstraints()
        
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .systemGray6
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = Colors.purple
        navigationItem.title = habitName
        
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonClicked))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    @objc func editButtonClicked() {
        let habitController = HabitViewController()
        navigationController?.pushViewController(habitController, animated: true)
        habitController.currentHabit = self.currentHabit
        habitController.habitName = currentHabit?.name
    }

}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: HabitDetailsTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.tracking.rawValue,
            for: indexPath
        ) as? HabitDetailsTableViewCell else {
            fatalError()
        }
        
        cell.trackDayLabel.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        
        if HabitsStore.shared.habit(currentHabit!, isTrackedIn: store.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            //HabitDetailsViewController.count += 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.dates.count
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
}


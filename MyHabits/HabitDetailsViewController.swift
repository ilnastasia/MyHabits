
import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habitName: String?
    var currentHabit: Habit?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .systemGray6
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = Colors.purple
        navigationItem.title = habitName
        
        
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonClicked))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonClicked() {
        let habitController = HabitViewController()
        navigationController?.pushViewController(habitController, animated: true)
        habitController.currentHabit = self.currentHabit
    }

}

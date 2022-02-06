
import UIKit

class HabitsViewController: UIViewController {
    
    var habitController: HabitViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(UIColor(red: 161 / 255, green: 22 / 255, blue: 204 / 255, alpha: 1), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(toNewHabit))
        self.navigationItem.rightBarButtonItem = addButton
        
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    
    
    @objc func toNewHabit() {
        habitController = HabitViewController()
        let navBarOnModalHabitViewController = UINavigationController(rootViewController: habitController!)
        navBarOnModalHabitViewController.modalPresentationStyle = .fullScreen
        self.present(navBarOnModalHabitViewController, animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
    }
}

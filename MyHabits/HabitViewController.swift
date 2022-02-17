
import UIKit

class HabitViewController: UIViewController {
    
    let store = HabitsStore.shared
    var currentHabit: Habit?
    var habitName: String?
    
    let newHabitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "KohinoorBangla-Semibold", size: 13)
        label.text = "НАЗВАНИЕ"
        return label
    }()
     
    let newHabitNameField: UITextField = {
        let field = UITextField()
        field.toAutoLayout()
        field.textColor = Colors.blue
        field.font = UIFont(name: "Helvetica-Bold", size: 17)
        field.borderStyle = .none
        field.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return field
    }()
    
    let newHabitColorLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "KohinoorBangla-Semibold", size: 13)
        label.text = "ЦВЕТ"
        return label
    }()
    
    let pickColorButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = Colors.orange
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(pickColorButtonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func pickColorButtonClicked() {
        let colorPicker = ColorPickerViewController()
        colorPicker.selectedColor = pickColorButton.backgroundColor ?? .black
        colorPicker.delegate = self
        self.navigationController?.pushViewController(colorPicker, animated: true)   
    }
    
    let pickTimeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KohinoorBangla-Semibold", size: 13)
        label.text = "ВРЕМЯ"
        label.toAutoLayout()
        return label
    }()
    
    let everyDayLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Каждый день в "
        return label
    }()
    
    let pickedTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.purple
        label.toAutoLayout()
        return label
    }()
    
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.toAutoLayout()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        picker.timeZone = .autoupdatingCurrent
        return picker
    }()
    
    let deleteHabitButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
            if let hour = components.hour, let minute = components.minute {
                pickedTimeLabel.text = "\(hour):\(minute)"
        }
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            newHabitNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            newHabitNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            newHabitNameLabel.widthAnchor.constraint(equalToConstant: 120),
            newHabitNameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            newHabitNameField.topAnchor.constraint(equalTo: newHabitNameLabel.bottomAnchor, constant: 7),
            newHabitNameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            newHabitNameField.widthAnchor.constraint(equalToConstant: 350),
            newHabitNameField.heightAnchor.constraint(equalToConstant: 22),
            
            newHabitColorLabel.topAnchor.constraint(equalTo: newHabitNameField.bottomAnchor, constant: 15),
            newHabitColorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            newHabitColorLabel.widthAnchor.constraint(equalToConstant: 40),
            newHabitColorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            pickColorButton.topAnchor.constraint(equalTo: newHabitColorLabel.bottomAnchor, constant: 7),
            pickColorButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            pickColorButton.widthAnchor.constraint(equalToConstant: 30),
            pickColorButton.heightAnchor.constraint(equalToConstant: 30),
            
            pickTimeName.topAnchor.constraint(equalTo: pickColorButton.bottomAnchor, constant: 15),
            pickTimeName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            pickTimeName.widthAnchor.constraint(equalToConstant: 50),
            pickTimeName.heightAnchor.constraint(equalToConstant: 18),
            
            everyDayLabel.topAnchor.constraint(equalTo: pickTimeName.bottomAnchor, constant: 7),
            everyDayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            everyDayLabel.widthAnchor.constraint(equalToConstant: 125),
            everyDayLabel.heightAnchor.constraint(equalToConstant: 23),
            
            pickedTimeLabel.topAnchor.constraint(equalTo: everyDayLabel.topAnchor),
            pickedTimeLabel.leftAnchor.constraint(equalTo: everyDayLabel.rightAnchor),
            pickedTimeLabel.widthAnchor.constraint(equalToConstant: 200),
            pickedTimeLabel.heightAnchor.constraint(equalToConstant: 23),
            
            timePicker.topAnchor.constraint(equalTo: everyDayLabel.bottomAnchor, constant: 15),
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Создать"
        navigationController?.navigationBar.barTintColor = .systemGray6
        
        view.addSubviews(newHabitNameLabel, newHabitNameField, newHabitColorLabel, pickColorButton, pickTimeName, everyDayLabel, pickedTimeLabel, timePicker)
        setupConstraints()
        tapToHideKeyboard()
        
        let returnButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnButtonClicked))
        returnButton.tintColor = Colors.purple
        self.navigationItem.leftBarButtonItem = returnButton
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonClicked))
        saveButton.tintColor = Colors.purple
        saveButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 17) ?? ""], for: .normal)
        self.navigationItem.rightBarButtonItem = saveButton
        
        let viewControllers = self.navigationController?.viewControllers
        
        if (viewControllers?.count ?? 0) < 2 {
            return
        } else {
            let previousVC = viewControllers?[(viewControllers?.count ?? 0) - 2]
            if previousVC is HabitDetailsViewController {
                navigationItem.title = "Править"
                view.addSubviews(deleteHabitButton)
                NSLayoutConstraint.activate([
                    deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
                    deleteHabitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    deleteHabitButton.widthAnchor.constraint(equalToConstant: 170),
                    deleteHabitButton.heightAnchor.constraint(equalToConstant: 22)
                ])
                
                deleteHabitButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)

                let returnButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnButtonOnEditControllerClicked))
                returnButton.tintColor = Colors.purple
                self.navigationItem.leftBarButtonItem = returnButton
                
                newHabitNameField.text = currentHabit?.name
                pickColorButton.backgroundColor = currentHabit?.color
                timePicker.date = currentHabit!.date
                pickedTimeLabel.text = currentHabit?.dateString
                
                let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonOnEditControllerClicked))
                saveButton.tintColor = Colors.purple
                saveButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 17) ?? ""], for: .normal)
                self.navigationItem.rightBarButtonItem = saveButton
            }
        }
    }
    
    @objc func returnButtonOnEditControllerClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonOnEditControllerClicked() {
        let habitsController = self.navigationController?.viewControllers.filter({$0 is HabitsViewController}).first
        self.navigationController?.popToViewController(habitsController!, animated: true)

        store.habits.filter({$0.name == currentHabit?.name}).forEach({$0.name = newHabitNameField.text ?? ""})
        store.habits.filter({$0.date == currentHabit?.date}).forEach({$0.date = timePicker.date})
        store.habits.filter({$0.color == currentHabit?.color}).forEach({$0.color = pickColorButton.backgroundColor ?? .black})
        store.save()
    }
    
    @objc func deleteButtonClicked() {
        
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(String(describing: currentHabit!.name))\"?", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: {action in
            switch action.style {
            case .default:
                print("")

            case .cancel:
                self.dismiss(animated: true, completion: nil)

            case .destructive:
                self.deletingHabit(with: self.currentHabit!)
                let habitsController =  self.navigationController?.viewControllers.filter({$0 is HabitsViewController}).first
                self.navigationController?.popToViewController(habitsController!, animated: true)
            @unknown default:
                fatalError()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { action in
            switch action.style {
            case .default:
                print("")

            case .cancel:
                self.dismiss(animated: true, completion: nil)

            case .destructive:
                self.deletingHabit(with: self.currentHabit!)
                let habitsController = self.navigationController?.viewControllers.filter({$0 is HabitsViewController}).first
                self.navigationController?.popToViewController(habitsController!, animated: true)
            @unknown default:
                fatalError()
            }
        }))
    }
    
    func deletingHabit(with habit: Habit) {
        //let store = HabitsStore.shared
        store.habits.removeAll(where: {$0.name == habit.name})
    }
    
    
    @objc func returnButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonClicked() {
        let newHabit = Habit(name: newHabitNameField.text ?? "",
                             date: timePicker.date,
                             color: pickColorButton.backgroundColor ?? .black)
        //let store = HabitsStore.shared
        store.habits.append(newHabit)
        dismiss(animated: true, completion: nil)
        //print(store.habits.count)
    }
    
    @objc func tapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        pickColorButton.backgroundColor = viewController.selectedColor
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        pickColorButton.backgroundColor = viewController.selectedColor
    }
}

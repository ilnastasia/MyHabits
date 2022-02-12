
import UIKit

protocol ReusableHabitView: AnyObject {
    static var habitIdentifier: String { get }
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    let store = HabitsStore.shared
    
    let habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        //label.numberOfLines = 0  разобраться с количеством строк
        
        return label
    }()
    
    let habitTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .systemGray2
        label.font = UIFont(name: "Helvetica-Regular", size: 12)
        return label
    }()
    
    let habitsCounterLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .systemGray
        label.font = UIFont(name: "Helvetica-Regular", size: 13)
        label.text = "Счетчик: "
        return label
    }()
    
    let habitTrackingButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        //button.clipsToBounds = true
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(trackingButtonIsClicked(habit:)), for: .touchUpInside)
        // цвет границы
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(habitNameLabel, habitTimeLabel, habitsCounterLabel, habitTrackingButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func trackingButtonIsClicked(habit: Habit) {
        habitTrackingButton.backgroundColor = habitNameLabel.textColor
        habitTrackingButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        habitTrackingButton.tintColor = .white
        
        if habit.isAlreadyTakenToday == false {
            store.track(habit)
        }
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitNameLabel.widthAnchor.constraint(equalToConstant: 300),
            habitNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitTimeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitTimeLabel.widthAnchor.constraint(equalToConstant: 200),
            habitTimeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            habitsCounterLabel.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: 30),
            habitsCounterLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitsCounterLabel.widthAnchor.constraint(equalToConstant: 188),
            habitsCounterLabel.heightAnchor.constraint(equalToConstant: 18),
            
            habitTrackingButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            habitTrackingButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            habitTrackingButton.widthAnchor.constraint(equalToConstant: 38),
            habitTrackingButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    public func update(with habit: Habit) {
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitTimeLabel.text = habit.dateString
        habitsCounterLabel.layer.borderColor = habit.color.cgColor
    }
}

extension HabitCollectionViewCell: ReusableHabitView {
    static var habitIdentifier: String {
        return String(describing: self)
    }
}

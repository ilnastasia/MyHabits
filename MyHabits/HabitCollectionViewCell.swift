
import UIKit

protocol ReusableHabitView: AnyObject {
    static var habitIdentifier: String { get }
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    let store = HabitsStore.shared
    var currentHabit: Habit?
    var habitTrackClosure: (()->())?
    
    let habitNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.numberOfLines = 2
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
        return label
    }()
    
    let habitTrackingButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(trackingButtonIsClicked), for: .touchUpInside)
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
    
    @objc func trackingButtonIsClicked(sender: UIButton) {
        fillCircle()
        habitTrackClosure?()
    }
    
    func fillCircle() {
        habitTrackingButton.backgroundColor = habitNameLabel.textColor
        habitTrackingButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        habitTrackingButton.tintColor = .white
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitNameLabel.widthAnchor.constraint(equalToConstant: 300),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitTimeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitTimeLabel.widthAnchor.constraint(equalToConstant: 200),
            habitTimeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            habitsCounterLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitsCounterLabel.widthAnchor.constraint(equalToConstant: 188),
            habitsCounterLabel.heightAnchor.constraint(equalToConstant: 18),
            habitsCounterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
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
        habitTrackingButton.layer.borderColor = habit.color.cgColor
        habitsCounterLabel.text = "Счетчик: \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday == true {
            fillCircle()
            habitTrackingButton.isEnabled = false
        } else {
            habitTrackingButton.backgroundColor = .clear
        }
    }
}

extension HabitCollectionViewCell: ReusableHabitView {
    static var habitIdentifier: String {
        return String(describing: self)
    }
}


import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    let trackDayLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Helvetica-Regular", size: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(trackDayLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            trackDayLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            trackDayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            trackDayLabel.widthAnchor.constraint(equalToConstant: 150),
            trackDayLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        let constraint = contentView.heightAnchor.constraint(equalToConstant: 44)
        constraint.isActive = true
        constraint.priority = UILayoutPriority(751)
    }
    
    public func update(date: Date) {
        
        
        // ! формат только дата и добавить сегодня и вчера
        // ! обновление каждый день
        // ! сделать в обратном порядке и с даты добавления
        // ! сохранить изменение привычки и заполнение кружка
        // ! разобраться с багом TableView
        // настроить счетчик
        // ! галочку фиолетовую
        // пройтись по всему коду и сделать красиво
        // ! разобраться с каждый день в
    }
}

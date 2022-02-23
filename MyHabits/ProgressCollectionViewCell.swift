
import UIKit

protocol ReusableProgressView: AnyObject {
    static var progressIdentifier: String { get }
}

class ProgressCollectionViewCell: UICollectionViewCell {

    let motivatingLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Все получится!"
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        label.textColor = .systemGray
        return label
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.toAutoLayout()
        view.progressViewStyle = .default
        view.trackTintColor = .systemGray2
        view.progressTintColor = Colors.purple
        view.layer.cornerRadius = 3.5
        view.clipsToBounds = true
        return view
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .systemGray
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.addSubviews(motivatingLabel, progressView, percentLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgressOfHabits() {
        let store = HabitsStore.shared
        progressView.setProgress(store.todayProgress, animated: true)
        percentLabel.text = String(Int(store.todayProgress * 100.0)) + "%"
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            motivatingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            motivatingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            motivatingLabel.widthAnchor.constraint(equalToConstant: 220),
            motivatingLabel.heightAnchor.constraint(equalToConstant: 18),
            
            progressView.topAnchor.constraint(equalTo: motivatingLabel.bottomAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            percentLabel.widthAnchor.constraint(equalToConstant: 50),
            percentLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        let constraint = progressView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12)
        constraint.isActive = true
        constraint.priority = UILayoutPriority(751)
        
        let constraint2 = progressView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12)
        constraint2.isActive = true
        constraint2.priority = UILayoutPriority(751)
    }
}

extension ProgressCollectionViewCell: ReusableProgressView {
    static var progressIdentifier: String {
        return String(describing: self)
    }
}

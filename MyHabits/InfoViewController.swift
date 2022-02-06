
import UIKit

class InfoViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = Content.infoName
        label.font = UIFont(name: "Helvetica-Bold", size : 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoFirstText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoSecondText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thirdTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoThirdText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fourthTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoFourthText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fifthTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoFifthText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sixthTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoSixthText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seventhTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoSeventhText
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let eighthTextView: UILabel = {
        let view = UILabel()
        view.text = Content.infoEighthText
        view.numberOfLines = 0
        view.font = UIFont(name: "Helvetica-Regular", size : 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Информация"
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(firstTextView)
        contentView.addSubview(secondTextView)
        contentView.addSubview(thirdTextView)
        contentView.addSubview(fourthTextView)
        contentView.addSubview(fifthTextView)
        contentView.addSubview(sixthTextView)
        contentView.addSubview(seventhTextView)
        contentView.addSubview(eighthTextView)
        setupViews()
    }
    
    func setupViews() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
            nameLabel.widthAnchor.constraint(equalToConstant: 230),
            
            firstTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            firstTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            firstTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            firstTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            secondTextView.topAnchor.constraint(equalTo: firstTextView.bottomAnchor, constant: 12),
            secondTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            secondTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            thirdTextView.topAnchor.constraint(equalTo: secondTextView.bottomAnchor, constant: 12),
            thirdTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            thirdTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            fourthTextView.topAnchor.constraint(equalTo: thirdTextView.bottomAnchor, constant: 12),
            fourthTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fourthTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            fifthTextView.topAnchor.constraint(equalTo: fourthTextView.bottomAnchor, constant: 12),
            fifthTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fifthTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            sixthTextView.topAnchor.constraint(equalTo: fifthTextView.bottomAnchor, constant: 12),
            sixthTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sixthTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            seventhTextView.topAnchor.constraint(equalTo: sixthTextView.bottomAnchor, constant: 12),
            seventhTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            seventhTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            eighthTextView.topAnchor.constraint(equalTo: seventhTextView.bottomAnchor, constant: 12),
            eighthTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eighthTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            eighthTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

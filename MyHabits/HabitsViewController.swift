
import UIKit

class HabitsViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.progressIdentifier)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.habitIdentifier)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        setupConstraints()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubviews(collectionView)
    }
    
    func setupAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(toNewHabit))
        addButton.tintColor = Colors.purple
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @objc func toNewHabit() {
        let habitController = HabitViewController()
        let navBarOnModalHabitViewController = UINavigationController(rootViewController: habitController)
        navBarOnModalHabitViewController.modalPresentationStyle = .fullScreen
        self.present(navBarOnModalHabitViewController, animated: true, completion: nil)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "??????????????"
        navigationController?.navigationBar.barTintColor = .white
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.progressIdentifier,
                for: indexPath
            ) as? ProgressCollectionViewCell else {
                fatalError()
            }
            cell.setProgressOfHabits()
            return cell
        } else {
            guard let cell: HabitCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCollectionViewCell.habitIdentifier,
                for: indexPath
            ) as? HabitCollectionViewCell else {
                fatalError()
            }
            let habit = HabitsStore.shared.habits[indexPath.row]
            cell.update(with: habit)
            cell.habitTrackClosure = { [weak self] in
                if habit.isAlreadyTakenToday == false {
                    HabitsStore.shared.track(habit)
                }
                self?.collectionView.reloadData()
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 60)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 22,
            left: 16,
            bottom: 0,
            right: 16
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = HabitDetailsViewController()
        if indexPath.section != 0 {
            navigationController?.pushViewController(detailsController, animated: true)
        }
        let habit = HabitsStore.shared.habits[indexPath.row]
        detailsController.habitName = habit.name
        detailsController.currentHabit = habit
    }
}



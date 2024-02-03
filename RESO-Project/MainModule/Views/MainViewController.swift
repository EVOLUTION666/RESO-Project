//
//  ViewController.swift
//  RESO-Project
//
//  Created by Andrey on 04.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let locationService = LocationService.shared
    
    var output: MainViewOutput!
    
    private lazy var getListButton: UIButton = {
        let getListButton = UIButton()
        getListButton.setTitle("Получить список офисов", for: .normal)
        getListButton.setTitleColor(UIColor.black, for: .normal)
        getListButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        getListButton.titleLabel?.numberOfLines = 0
        getListButton.titleLabel?.textAlignment = .center
        getListButton.backgroundColor = .lightGray
        getListButton.layer.cornerRadius = 12
        getListButton.clipsToBounds = true
        getListButton.translatesAutoresizingMaskIntoConstraints = false
        getListButton.addTarget(self, action: #selector(getListButtonDidTap), for: .touchUpInside)
        return getListButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationService.requestAuthorization()
    }
}

extension MainViewController: MainViewInput {
    func navigate(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Private methods

extension MainViewController {
    private func configureUI() {
        view.addSubview(getListButton)
        view.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        title = ""
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            getListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            getListButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            getListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//MARK: - @objc methods

extension MainViewController {
    @objc func getListButtonDidTap() {
        output.didTap()
    }
}

//
//  OfficeViewController.swift
//  RESO-Project
//
//  Created by Andrey on 04.05.2022.
//

import UIKit

class OfficeViewController: UIViewController {
    
    private let adapter = TableViewAdapter()
    
    var output: OfficeViewOutput!
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Списком", "На карте"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedFunc), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var viewForSegmentedControl: UIView = {
        let viewForSegmentedControl = UIView()
        viewForSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        viewForSegmentedControl.backgroundColor = .systemGreen
        return viewForSegmentedControl
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage.init()
        searchBar.barTintColor = .gray
        searchBar.tintColor = .gray
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        configureUI()
        adapter.delegate = output
        adapter.arrayOffices = output.officeArray
        adapter.didScrollClosure = { [weak self] in
            self?.searchBar.endEditing(true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Офисы РЕСО-Гарантия"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension OfficeViewController: OfficeViewInput {
    
    func updateData() {
        adapter.arrayOffices = output.officeArray
        tableView.reloadData()
    }
    
    func showError(error: String) {
        showAlert(title: "Ошибка", message:  error)
    }
    
    func navigate(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Private method

extension OfficeViewController {
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "sort"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .systemGreen
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(viewForSegmentedControl)
        viewForSegmentedControl.addSubview(segmentedControl)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            viewForSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor),
            viewForSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: viewForSegmentedControl.layoutMarginsGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: viewForSegmentedControl.layoutMarginsGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: viewForSegmentedControl.layoutMarginsGuide.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: viewForSegmentedControl.layoutMarginsGuide.bottomAnchor),
            
            searchBar.topAnchor.constraint(equalTo: viewForSegmentedControl.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

//MARK: - @objc methods

extension OfficeViewController {
    @objc func segmentedFunc(_ segmentedControl: UISegmentedControl) {
        tableView.isHidden = segmentedControl.selectedSegmentIndex == 1
        searchBar.isHidden = segmentedControl.selectedSegmentIndex == 1
    }
}

//MARK: - UISearchBarDelegate

extension OfficeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.didChangeSearchText(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}


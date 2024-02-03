//
//  CustomTableViewCell.swift
//  RESO-Project
//
//  Created by Andrey on 05.05.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return titleLabel
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.textColor = .lightGray
        addressLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        addressLabel.numberOfLines = 0
        addressLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return addressLabel
    }()
    
    private lazy var openCloseLabel: UILabel = {
        let openCloseLabel = UILabel()
        openCloseLabel.translatesAutoresizingMaskIntoConstraints = false
        openCloseLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        openCloseLabel.textColor = .green
        return openCloseLabel
    }()
    
    private lazy var distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        distanceLabel.textColor = .gray
        return distanceLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var generalStack: UIStackView = {
        let generalStack = UIStackView(arrangedSubviews: [titleLabel, addressLabel, distanceStack])
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        generalStack.distribution = .fill
        generalStack.axis = .vertical
        generalStack.spacing = 8
        return generalStack
    }()
    
    private lazy var distanceStack: UIStackView = {
        let distanceStack = UIStackView(arrangedSubviews: [openCloseLabel, distanceLabel])
        distanceStack.translatesAutoresizingMaskIntoConstraints = false
        distanceStack.axis = .horizontal
        distanceStack.spacing = 4
        distanceStack.distribution = .fillProportionally
        distanceStack.alignment = .fill
        return distanceStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureModel(officeModel: OfficeElement) {
        
        titleLabel.text = officeModel.sshortname
        addressLabel.text = officeModel.sshortaddress
        
        if let distance = LocationService.shared.getDistance(lat: officeModel.nlat, lon: officeModel.nlong) {
            let roundedDistance = distance.rounded()
            distanceLabel.text = "до офиса: \(roundedDistance / 1000) км."
        } else {
            distanceLabel.text = "Неизвестно"
        }
        
        openCloseLabel.text = officeModel.officeIsOpen() ? "Открыто" : "Закрыто"
        openCloseLabel.textColor = officeModel.officeIsOpen() ? .green : .red
        
    }
}

//MARK: - Private methods

extension CustomTableViewCell {
    
    private func configureUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        contentView.addSubview(generalStack)
        contentView.addSubview(button)
    }
    
    private func setupConstraints() {
        
        button.setContentHuggingPriority(.required, for: .horizontal)
        openCloseLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            
            button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20),
            
            generalStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            generalStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            generalStack.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            generalStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            
        ])
    }
}

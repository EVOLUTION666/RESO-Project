//
//  DetailsViewController.swift
//  RESO-Project
//
//  Created by Andrey on 05.05.2022.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    private let locationService = LocationService.shared
    
    var output: DetailsViewOutput!
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var mapViewGoButton: UIButton = {
       let mapViewGoButton = UIButton()
        mapViewGoButton.translatesAutoresizingMaskIntoConstraints = false
        mapViewGoButton.tintColor = .white
        mapViewGoButton.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
        mapViewGoButton.setImage(UIImage(named: "route")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return mapViewGoButton
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLabel
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.textColor = .black
        addressLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    
    private lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.textColor = .black
        phoneLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        phoneLabel.numberOfLines = 0
        return phoneLabel
    }()
    
    private lazy var workingModeLabel: UILabel = {
        let workingModeLabel = UILabel()
        workingModeLabel.translatesAutoresizingMaskIntoConstraints = false
        workingModeLabel.text = "Режим работы"
        workingModeLabel.textColor = .lightGray
        workingModeLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        workingModeLabel.numberOfLines = 0
        return workingModeLabel
    }()
    
    private lazy var workingTimesLabel: UILabel = {
        let workingTimesLabel = UILabel()
        workingTimesLabel.translatesAutoresizingMaskIntoConstraints = false
        workingTimesLabel.textColor = .black
        workingTimesLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        workingTimesLabel.numberOfLines = 0
        return workingTimesLabel
    }()
    
    private lazy var generalStack: UIStackView = {
        let generalStack = UIStackView(arrangedSubviews: [titleLabel, addressLabel, phoneLabel, workingModeLabel, workingTimesLabel])
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        generalStack.axis = .vertical
        generalStack.distribution = .fill
        generalStack.spacing = 10
        return generalStack
    }()
    
    private lazy var callButton: UIButton = {
        let callButton = UIButton()
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.backgroundColor = .systemGreen
        callButton.setTitle("Позвонить", for: .normal)
        return callButton
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
       let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.opacity = 0.5
        gradientLayer.name = "gradient"
        return gradientLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.didLoadViews()
        configureUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: navigationController?.navigationBar.frame.maxY ?? 0)
    }
}

extension DetailsViewController: DetailsViewInput {
    func setupModel(model: OfficeElement) {
        titleLabel.text = model.sshortname
        addressLabel.text = model.saddress
        phoneLabel.text = model.sphone
        workingTimesLabel.text = model.sgraf
        
        let targetLocation = CLLocationCoordinate2D(latitude: model.nlat, longitude: model.nlong)
        let region = MKCoordinateRegion(center: targetLocation, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
        let annotation = MKPointAnnotation()
        annotation.title = model.sshortname
        annotation.coordinate = targetLocation
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}

//MARK: - Private methods

extension DetailsViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.backgroundColor = .clear
        configureSubviews()
        setupConstraints()
    }
    
    private func configureSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(mapViewGoButton)
        view.addSubview(scrollView)
        view.addSubview(callButton)
        scrollView.addSubview(generalStack)
        mapView.layer.addSublayer(gradientLayer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            mapViewGoButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -20),
            mapViewGoButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20),
            mapViewGoButton.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.1),
            mapViewGoButton.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.1),
            
            scrollView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: callButton.topAnchor),
            
            generalStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 25),
            generalStack.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            generalStack.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            generalStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            callButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
            
        ])
    }
    
    private func createDirectionRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: output.model.nlat, longitude: output.model.nlong)
        
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        
        return request
    }
}

//MARK: - @objc methods

extension DetailsViewController {
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
    
    @objc func goButtonPressed() {
        guard let currentLocation = locationService.currentLocation?.coordinate else { return }
        let directions = MKDirections(request: createDirectionRequest(from: currentLocation))
            directions.calculate { response, error in
            guard let response = response else { return }
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
}

//MARK: - MKMapViewDelegate

extension DetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = #colorLiteral(red: 1, green: 0.7389854193, blue: 0, alpha: 1)
        
        return renderer
    }
}

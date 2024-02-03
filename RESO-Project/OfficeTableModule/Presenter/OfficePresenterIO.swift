//
//  OfficePresenterIO.swift
//  RESO-Project
//
//  Created by Andrey on 05.05.2022.
//

import UIKit

enum OfficeModuleBuilder {
    static func buildOfficeModule() -> UIViewController {
        let view = OfficeViewController()
        let presenter = OfficePresenterIO(view: view, apiService: RESOApiService.shared)
        view.output = presenter
        return view
    }
}

protocol OfficeViewInput: AnyObject {
    func navigate(viewController: UIViewController)
    func updateData()
    func showError(error: String)
}

protocol OfficeViewOutput: TableViewAdapterDelegate {
    var officeArray: [OfficeElement] { get }
    func viewDidLoad()
    func didChangeSearchText(text: String?)
}

class OfficePresenterIO: OfficeViewOutput {
    
    private let apiService: RESOApiService
    var officeArray = [OfficeElement]()
    
    private var allOffices = [OfficeElement]()
    
    private weak var input: OfficeViewInput!
    
    init(view: OfficeViewInput, apiService: RESOApiService) {
        self.input = view
        self.apiService = apiService
    }
    
    func viewDidLoad() {
        loadOffices()
    }
    
    func didChangeSearchText(text: String?) {
        guard let searchText = text, searchText != "" else {
            officeArray = allOffices
            input.updateData()
            return
        }
        officeArray = allOffices.filter({ $0.sshortname.lowercased().contains(searchText.lowercased())})
        input.updateData()
    }
    
    private func loadOffices() {
        apiService.getOffices { [weak self] offices in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch offices {
                case .failure(let error):
                    self.input.showError(error: error.localizedDescription)
                case .success(let response):
                    let decodedArray: [OfficeElement]? = response.decodedModel()
                    self.officeArray = decodedArray ?? []
                    self.allOffices = decodedArray ?? []
                    self.input.updateData()
                }
            }
        }
    }
}

extension OfficePresenterIO: TableViewAdapterDelegate {
    func didSelect(office: OfficeElement) {
        let detailsViewController = DetailsModuleBuilder.buildDetailsModule(selectedOffice: office)
        input.navigate(viewController: detailsViewController)
    }
}

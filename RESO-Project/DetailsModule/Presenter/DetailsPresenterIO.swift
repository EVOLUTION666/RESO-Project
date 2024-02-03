//
//  DetailsPresenterIO.swift
//  RESO-Project
//
//  Created by Andrey on 06.05.2022.
//

import Foundation
import UIKit

enum DetailsModuleBuilder {
    static func buildDetailsModule(selectedOffice: OfficeElement) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenterIO(view: view, selectedOffice: selectedOffice)
        view.output = presenter
        return view
    }
}

protocol DetailsViewInput: AnyObject {
    func setupModel(model: OfficeElement)
}

protocol DetailsViewOutput {
    var model: OfficeElement { get }
    func didLoadViews()
}

class DetailsPresenterIO: DetailsViewOutput {
    
    private weak var input: DetailsViewInput!
    
    var model: OfficeElement
    
    init(view: DetailsViewInput, selectedOffice: OfficeElement) {
        self.input = view
        self.model = selectedOffice
    }
    
    func didLoadViews() {
        loadData()
    }
    
    private func loadData() {
        input.setupModel(model: model)
    }
}

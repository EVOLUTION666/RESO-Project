//
//  MainPresenterIO.swift
//  RESO-Project
//
//  Created by Andrey on 05.05.2022.
//

import UIKit

enum MainModuleBuilder {
    static func buildMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenterIO(view: view)
        view.output = presenter
        return view
    }
}

protocol MainViewInput: AnyObject {
    func navigate(viewController: UIViewController)
}

protocol MainViewOutput {
    func didTap()
}

class MainPresenterIO: MainViewOutput {
    
    private weak var input: MainViewInput!
    
    init(view: MainViewInput) {
        self.input = view
    }
    
    func didTap() {
        let officeViewController = OfficeModuleBuilder.buildOfficeModule()
        input?.navigate(viewController: officeViewController)
    }
}

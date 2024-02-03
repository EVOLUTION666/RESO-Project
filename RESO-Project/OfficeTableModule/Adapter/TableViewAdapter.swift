//
//  TableViewAdapter.swift
//  RESO-Project
//
//  Created by Andrey on 05.05.2022.
//

import Foundation
import UIKit

protocol TableViewAdapterDelegate: AnyObject {
    func didSelect(office: OfficeElement)
}

class TableViewAdapter: NSObject {
    weak var delegate: TableViewAdapterDelegate?
    var arrayOffices = [OfficeElement]()
    var didScrollClosure: (()->())?
}

extension TableViewAdapter: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOffices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.configureModel(officeModel: arrayOffices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(office: arrayOffices[indexPath.row])
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        didScrollClosure?()
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        didScrollClosure?()
    }
    
}

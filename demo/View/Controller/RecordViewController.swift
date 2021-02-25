//
//  RecordViewController.swift
//  demo
//
//  Created by dr on 2021/2/24.
//

import Foundation
import UIKit

class RecordViewController: UIViewController {
    
    private var viewModel: RecordViewModelType!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RecordViewModel(service: ItemService())
        viewModel.dataSource.bind(
            to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)
        ) { (row, elememt, cell) in
            cell.textLabel?.text = "\(elememt.requestTime)--->\(elememt.responseTime)"
        }.disposed(by: rx.disposeBag)
    }
}

//
//  CoinListViewController.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import ReactiveCocoa
import ReactiveSwift
import UIKit

class CoinListViewController: UIViewController {
    @IBOutlet private weak var coinListTableView: UITableView!
    
    private let viewDidLoadPipe = Signal<(), Never>.pipe()
    private let identifier = Constants.coinCellIdentifier
    private var coins = [CoinModel]()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        registerTableViewCells()
        bindViewModel()
        viewDidLoadPipe.input.send(value: ())
    }
    
    private func setupNavigationBar() {
        let textButtonItem = UIBarButtonItem(title: "USD", style: .done, target: self, action: nil)
        textButtonItem.tintColor = Constants.Collors.barItemGray
        
        let searchButtonItem = UIBarButtonItem(image: Constants.Icons.search?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchAction))
        
        navigationItem.rightBarButtonItems = [searchButtonItem, textButtonItem]
    }
    
    private func registerTableViewCells() {
        let coinCell = UINib(nibName: identifier,
                             bundle: nil)
        self.coinListTableView.register(coinCell,
                                        forCellReuseIdentifier: identifier)
    }
    
    @objc private func searchAction() {
        print("Search Coin")
    }
    
    // MARK: Bind Model
    
    private func bindViewModel() {
        let output = CoinListViewModel.create(
            input: .init(
                lifetime: self.reactive.lifetime,
                viewDidLoad: self.viewDidLoadPipe.output
            )
        )
        
        output.getListSignal.observeValues { [weak self] coins in
            self?.coins = coins
            
            DispatchQueue.main.async {
                self?.coinListTableView.reloadData()
            }
        }
        
        output.updateIndexPathSignal.observeValues { [weak self] indexPaths in
            DispatchQueue.main.async {
                self?.coinListTableView.reloadRows(at: indexPaths, with: .automatic)
            }
        }
    }
}

// MARK: UITableViewDataSource

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CoinTableViewCell {
            let coin = coins[indexPath.row]
            
            cell.setup(with: coin)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

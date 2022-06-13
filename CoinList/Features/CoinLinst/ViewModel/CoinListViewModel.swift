//
//  CoinListViewModel.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import ReactiveSwift
import Foundation

enum CoinListViewModel: CoinListBusinessRules {
    struct Input {
        let lifetime: Lifetime
        let viewDidLoad: Signal<(), Never>
    }
    
    struct Output {
        let getListSignal: Signal<[CoinModel], Never>
        let updateIndexPathSignal: Signal<[IndexPath], Never>
    }
    
    static func create(input: Input) -> Output {
        let (updateListSignal, updateListObserver) = Signal<(Void), Never>.pipe()
        let (updateIndexPathSignal, updateIndexPathObserver) = Signal<([IndexPath]), Never>.pipe()
        let (filterDataSignal, filterDataObserver) = Signal<([CoinData]), Never>.pipe()
        let coinModelsMutableProperty: MutableProperty<[CoinModel]> = .init([])
        
        input.lifetime += input.viewDidLoad.signal.observeValues {
            CoinListRepository
                .getCoinList()
                .observe(on: UIScheduler())
                .on(failed: { error in
                    print(error)
                },
                    value: { response in
                    let coinModels = response.coins.map { CoinModel(coin: $0)}
                    
                    coinModelsMutableProperty.value = coinModels
                    updateListObserver.send(value: ())
                })
                .start()
        }
        
        updateListSignal.observeValues { _ in
            guard Reachability.isConnectedToNetwork() else { return }
            
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer: Timer) in
                CoinListRepository
                    .updateCoinList()
                    .observe(on: UIScheduler())
                    .on(failed: { error in
                        print(error)
                    },
                        value: { response in
                        filterDataObserver.send(value: response.coins)
                    })
                    .start()
            })
        }
        
        filterDataSignal.observeValues { dataCoins in
            let identifieres = dataCoins.compactMap { $0.identifier }
            var indexPaths: [IndexPath] = []
            
            for (index, coinModel) in coinModelsMutableProperty.value.enumerated() where identifieres.contains(coinModel.identifier) {
                let oldPrice = getPriceUSD(with: coinModel.identifier, array: dataCoins)
                
                if oldPrice != coinModel.coin.priceUSD {
                    coinModel.coin.priceUSD = oldPrice
                    indexPaths.append(IndexPath(row: index, section: 0))
                }
            }
            
            updateIndexPathObserver.send(value: indexPaths)
        }
        
        return Output(
            getListSignal: coinModelsMutableProperty.signal,
            updateIndexPathSignal: updateIndexPathSignal
        )
    }
}

protocol CoinListBusinessRules {
    static func getPriceUSD(with identifier: String, array: [CoinData]) -> Double
}

extension CoinListBusinessRules {
    static func getPriceUSD(with identifier: String, array: [CoinData]) -> Double {
        let coin = array.first { $0.identifier == identifier }
        
        return coin?.priceUSD ?? 0
    }
}

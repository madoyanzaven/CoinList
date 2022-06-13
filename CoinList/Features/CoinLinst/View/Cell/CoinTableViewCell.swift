//
//  CoinTableViewCell.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import AlamofireImage
import UIKit

class CoinTableViewCell: UITableViewCell {
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var percentStateImageView: UIImageView!
    @IBOutlet private weak var percentBackgroundView: UIView!
    
    private let downArrow = Constants.Icons.downArrow
    private let upArrow = Constants.Icons.upArrow
    private let mainRedColor = Constants.Collors.mainRed
    private let mainGreenColor = Constants.Collors.mainGreen
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        percentBackgroundView.layer.cornerRadius = 4
    }
    
    func setup(with model: CoinModel) {
        setupLabels(with: model)
        setupCoinImageView(with: model)
        setupPercentState(with: model)
    }
    
    private func setupLabels(with model: CoinModel) {
        coinNameLabel.text = model.name
        coinSymbolLabel.text = model.symbolText
        rankLabel.text = model.rankText
        priceLabel.text = model.priceUSDText
        percentLabel.text = model.percentValueText
    }
    
    private func setupPercentState(with model: CoinModel) {
        let hasNegativePercent = model.hasNegativePercent
        
        percentBackgroundView.backgroundColor = hasNegativePercent ? Constants.Collors.mainRed?.withAlphaComponent(0.1) : Constants.Collors.mainGreen?.withAlphaComponent(0.1)
        
        percentStateImageView.image = hasNegativePercent ? downArrow : upArrow
        percentLabel.textColor = hasNegativePercent ? mainRedColor : mainGreenColor
    }
    
    private func setupCoinImageView(with model: CoinModel) {
        if let imageUrl = model.imageUrl {
            DispatchQueue.main.async { [weak self] in
                self?.coinImageView.af.setImage(withURL: imageUrl)
            }
        }
    }
}

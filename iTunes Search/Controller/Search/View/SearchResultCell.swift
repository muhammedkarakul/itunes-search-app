//
//  SearchResultCollectionViewCell.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
    var name: String? {
        get {
            nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var price: Float? {
        get {
            Float(priceLabel.text ?? "")
        }
        set {
            priceLabel.text = String(newValue ?? 0) + "$"
        }
    }
    
    var relaseDate: Date? {
        get {
            return relaseDateFormatter.date(from: relaseDateLabel.text ?? "")
        }
        set {
            relaseDateLabel.text = relaseDateFormatter.string(from: newValue ?? Date())
        }
    }
    
    private lazy var relaseDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }()
    
    private(set) lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Collection Name"
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00$"
        label.font = UIFont.systemFont(ofSize: 11.0)
        return label
    }()
    
    private lazy var relaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "10 Jul 2020"
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        setupArtworkImageViewLayout()
        setupNameLabelLayout()
        setupPriceLabelLayout()
        setupRelaseDateLabelLayout()
    }
    
    private func setupArtworkImageViewLayout() {
        addSubview(artworkImageView)
        artworkImageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
    }
    
    private func setupNameLabelLayout() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalTo(artworkImageView.snp.bottom).offset(4.0)
            maker.trailing.equalToSuperview()
        }
    }
    
    private func setupPriceLabelLayout() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalTo(nameLabel.snp.bottom).offset(4.0)
            maker.bottom.equalToSuperview()
        }
    }
    
    private func setupRelaseDateLabelLayout() {
        addSubview(relaseDateLabel)
        relaseDateLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(priceLabel.snp.trailing).offset(8.0)
            maker.top.equalTo(nameLabel.snp.bottom).offset(4.0)
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}

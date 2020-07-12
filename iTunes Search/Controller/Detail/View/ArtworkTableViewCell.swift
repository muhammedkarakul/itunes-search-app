//
//  ArtworkTableViewCell.swift
//  iTunes Search
//
//  Created by Mete Karakul on 12.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import UIKit

final class ArtworkTableViewCell: UITableViewCell {
    var artworkImage: UIImage? {
        get {
            artworkImageView.image
        }
        set {
            artworkImageView.image = newValue
        }
    }
    
    private lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        setupArtworkImageViewLayout()
    }
    
    private func setupArtworkImageViewLayout() {
        addSubview(artworkImageView)
        artworkImageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}

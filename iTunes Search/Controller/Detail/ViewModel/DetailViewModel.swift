//
//  DetailViewModel.swift
//  iTunes Search
//
//  Created by Mete Karakul on 11.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import UIKit

final class DetailViewModel {
    private var sections: [Section] = []
    private var artworkImage: UIImage?
    var title: String?
    
    var numberOfSection: Int {
        sections.count + 1
    }
    
    var numberOfRows: Int {
        1
    }
    
    init(sections: [Section], artworkImage: UIImage?, title: String?) {
        self.sections = sections
        self.artworkImage = artworkImage
        self.title = title
    }
    
    func configure(_ cell: UITableViewCell, byIndex index: Int) {
        cell.textLabel?.text = sections[index - 1].data
    }
    
    func configure(_ cell: ArtworkTableViewCell) {
        cell.artworkImage = artworkImage
    }
    
    func titleFor(_ section: Int) -> String? {
        sections[section - 1].name
    }
}

//
//  DetailViewController.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    var detailViewModel: DetailViewModel?
    
    private lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        linkInteractor()
        registerCells()
        configureApperance()
        prepareLayout()
    }
    
    private func linkInteractor() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    private func registerCells() {
        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        detailTableView.register(ArtworkTableViewCell.self, forCellReuseIdentifier: "artworkCell")
    }
    
    private func configureApperance() {
        title = detailViewModel?.title
    }
    
    private func prepareLayout() {
        setupDetailTableViewLayout()
    }
    
    private func setupDetailTableViewLayout() {
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width
        }
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        detailViewModel?.numberOfSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "artworkCell", for: indexPath) as! ArtworkTableViewCell
            detailViewModel?.configure(cell)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        detailViewModel?.configure(cell, byIndex: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            return detailViewModel?.titleFor(section)
        }
        return nil
    }
}

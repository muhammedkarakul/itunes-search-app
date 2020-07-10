//
//  ViewController.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import UIKit
import JGProgressHUD

final class SearchViewController: UIViewController {

    private let searchViewModel = SearchViewModel()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.scopeButtonTitles = SearchType.allCases.map { $0.rawValue }
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var resultCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 24)/2, height: ((UIScreen.main.bounds.size.width - 24)/2))
        return flowLayout
    }()
    
    private lazy var noResultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no-result")
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "No results found!"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var resultCollectionBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var resultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: resultCollectionViewFlowLayout)
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.backgroundView = resultCollectionBackgroundView
        return collectionView
    }()
    
    private lazy var progressHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        return hud
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkInteractor()
        registerCells()
        configureApperance()
        prepareLayout()
    }
    
    private func linkInteractor() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    func registerCells() {
        resultCollectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: "searchResultCell")
    }
    
    func configureApperance() {
        title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func prepareLayout() {
        setupResultCollectionViewLayout()
        setupNoResultImageViewLayout()
        setupNoResultLabelLayout()
    }
    
    private func setupResultCollectionViewLayout() {
        view.addSubview(resultCollectionView)
        resultCollectionView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    private func setupNoResultImageViewLayout() {
        resultCollectionBackgroundView.addSubview(noResultImageView)
        noResultImageView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }
    
    private func setupNoResultLabelLayout() {
        resultCollectionBackgroundView.addSubview(noResultLabel)
        noResultLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalTo(noResultImageView.snp.bottom).offset(16.0)
            maker.trailing.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
}

// MARK - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        searchViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchResultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        let searchResultCellViewModel = searchViewModel.viewModelForCell(at: indexPath.row)
        searchResultCellViewModel.configure(searchResultCell)
        return searchResultCell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            searchViewModel.searchType = .movies
        case 1:
            searchViewModel.searchType = .music
        case 2:
            searchViewModel.searchType = .apps
        case 3:
            searchViewModel.searchType = .books
        default:
            break
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.count > 2 {
            progressHud.show(in: self.view)
            searchViewModel.search(withText: searchText, andLimit: 20) { error in
                self.progressHud.dismiss()
                if let error = error {
                    debugPrint(error)
                } else {
                    self.resultCollectionView.backgroundView?.isHidden = self.searchViewModel.numberOfItems > 0
                    self.resultCollectionView.reloadData()
                }
            }
        }
    }
}

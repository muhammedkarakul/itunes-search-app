//
//  ViewController.swift
//  iTunes Search
//
//  Created by Mete Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import UIKit

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
    
    private lazy var resultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkInteractor()
        registerCells()
        configureApperance()
        prepareLayout()
    }
    
    private func linkInteractor() {
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
        searchViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        return cell
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
        debugPrint(searchText)
    }
}

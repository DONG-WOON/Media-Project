//
//  SearchViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/23/23.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var searchedContents = [Contents]()
    var selectedMediaType: MediaType = .tv
    
    let segmentedControl = UISegmentedControl()
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        setNavigation()
        setAttributes()
        setConstraints()
    }
    
    @objc func toggle() {
        let mediaType: MediaType = selectedMediaType == .movie ? .tv : .movie
        
        selectedMediaType = mediaType
    }
}

extension SearchViewController: UIConfigurable {
    
    func setNavigation() {
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureViews() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
    }
    
    func setAttributes() {
        view.backgroundColor = .systemBackground
        
        searchBar.autocapitalizationType = .none
        searchBar.searchTextField.placeholder = "영화 / TV 프로그램을 영어로 검색하세요."
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: TMDBContentsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TMDBContentsTableViewCell.identifier)
        
        segmentedControl.insertSegment(withTitle: MediaType.tv.rawValue, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: MediaType.movie.rawValue, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .clear
        
        segmentedControl.addTarget(self, action: #selector(toggle), for: .valueChanged)
    }
    
    func setConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        let query = searchText.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed)
        
        APIManager.shared.request(.search(mediaType: selectedMediaType, queryItems: [URLQueryItem(name: "query", value: query)]), responseType: TrendingResponse.self) { response in
            let contentsList = response.results.map { original in
                var contents = original
                contents.mediaType = self.selectedMediaType
                return contents
            }
            self.searchedContents = contentsList
            self.tableView.reloadData()
        } onFailure: { error in
            print(error)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}

// MARK: - UITableView

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchedContents.isEmpty {
            return 1
        } else {
            return searchedContents.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchedContents.isEmpty {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No Result"
            return cell
       } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBContentsTableViewCell.identifier, for: indexPath) as? TMDBContentsTableViewCell else { return UITableViewCell() }
            cell.update(data: searchedContents[indexPath.row])
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = loadViewController(type: DetailViewController.self) else { return }
        vc.contentsDetail = searchedContents[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


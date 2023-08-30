//
//  TrendingViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/11/23.
//

import UIKit
import Combine

final class TrendingViewController: UIViewController {
    
    @Published var currentTitle = ContentsCategory.all.title
    
    lazy var categoryButton = UIBarButtonItem(image: UIImage(systemName: ImageKey.listBullet))
    private var anyCancellable = Set<AnyCancellable>()
    private var isLoading = false {
        didSet {
            activityIndicator.hidesWhenStopped = !isLoading
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }

    var contentsList = [Contents]()
    
    let activityIndicator = UIActivityIndicatorView()
    let tableView = UITableView()
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureViews()
        
        $currentTitle.sink { [weak self] title in
            self?.title = title
        }.store(in: &anyCancellable)
       
        setCategoryButton()
        callTrendingRequest(.all)
    }
    
    private func setCategoryButton() {
        navigationItem.leftBarButtonItem = categoryButton
        
        categoryButton.menu = UIMenu(children: [
            action(for: .all),
            action(for: .movie),
            action(for: .tv)
        ])
    }
    
    func callTrendingRequest(_ category: ContentsCategory) {
        isLoading = true
        
        var request: TMDBRequest {
            switch category {
            case .all: return .allTrending(path: .day)
            case .movie: return .movieTrending(path: .day)
            case .tv: return .tvTrending(path: .day)
            }
        }
        
        APIManager.shared.request(request, responseType: TrendingResponse.self) { [weak self] data in
            guard let self else { return }
            self.contentsList = data.results
            self.tableView.reloadData()
            self.isLoading = false
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        } onFailure: { error in
            print(error)
        }
    }
}

// MARK: TableViewController

extension TrendingViewController {
    
    func configureViews() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: TMDBContentsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TMDBContentsTableViewCell.identifier)
    }
}

extension TrendingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBContentsTableViewCell.identifier, for: indexPath) as? TMDBContentsTableViewCell else { return UITableViewCell()
        }
        
        cell.update(data: contentsList[indexPath.row])
        
        return cell
    }
}

extension TrendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = loadViewController(type: DetailViewController.self) else { return }
        vc.contentsDetail = contentsList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension TrendingViewController {
    func action(for contentsCategory: ContentsCategory) -> UIAction {
        let action = UIAction(title: contentsCategory.title) { [weak self] action in
            guard self?.currentTitle != contentsCategory.title else { return }
            self?.currentTitle = "\(contentsCategory.title) Trending"
            self?.callTrendingRequest(contentsCategory)
        }
        
        return action
    }
}

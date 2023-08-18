//
//  TrendingViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/11/23.
//

import UIKit
import Combine

final class TrendingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    @Published var currentTitle = ContentsCategory.all.title
    
    lazy var categoryButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"))
    private var anyCancellable = Set<AnyCancellable>()
    private var isLoading = false {
        didSet {
            activityIndicator.hidesWhenStopped = !isLoading
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }

    var contentsList = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = categoryButton
        
        $currentTitle.sink { [weak self] title in
            self?.title = title
        }.store(in: &anyCancellable)
       
        setCategoryButton()
        
        callTrendingRequest(.all)
    }
    
    private func setCategoryButton() {
        categoryButton.menu = UIMenu(children: [
            UIAction(title: ContentsCategory.all.title) { [weak self] action in
                guard self?.currentTitle != ContentsCategory.all.title else { return }
                self?.currentTitle = "\(ContentsCategory.all.title) Trending"
                self?.callTrendingRequest(.all)
            },
            UIAction(title: ContentsCategory.movie.title) { [weak self] action in
                guard self?.currentTitle != ContentsCategory.movie.title else { return }
                self?.currentTitle = "\(ContentsCategory.movie.title) Trending"
                self?.callTrendingRequest(.movie)
            },
            UIAction(title: ContentsCategory.tv.rawValue) { [weak self] action in
                guard self?.currentTitle != ContentsCategory.tv.title else { return }
                self?.currentTitle = "\(ContentsCategory.tv.title) Trending"
                self?.callTrendingRequest(.tv)
            }
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
        
        APIManager.shared.request(request, responseType: TrendingResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.contentsList = data.results
                self?.tableView.reloadData()
                self?.isLoading = false
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                //center vertically 
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: TableViewController

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
        
        guard let vc = storyboard?.instantiateViewController(identifier: CreditViewController.identifier) as? CreditViewController else { return }
        vc.contentsDetail = contentsList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


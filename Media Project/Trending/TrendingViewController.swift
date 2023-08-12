//
//  TrendingViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/11/23.
//

import UIKit

final class TrendingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var isLoading = false {
        didSet {
            activityIndicator.hidesWhenStopped = !isLoading
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    var contentsList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        callTrendingRequest()
    }
    
    func callTrendingRequest() {
        
        isLoading = true
        
        APIManager.shared.request(.trending(path: .day), responseType: TrendingResponse.self) { result in
            switch result {
            case .success(let data):
                self.contentsList = data.results
                self.tableView.reloadData()
                
                self.isLoading = false
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
        vc.movieDetail = contentsList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


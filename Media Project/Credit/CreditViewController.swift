//
//  CreditViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit
import Kingfisher

final class CreditViewController: UIViewController {
    
    var movieDetail: Movie?
    
    private var castList: [Cast] = []
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        update(data: movieDetail)
        callCastRequest()
    }
    
    private func update(data: Movie?) {
        guard let data else { return }
        backdropImageView.kf.setImage(with: URL(string: EndPoint.imageURL + data.backdropPath))
        posterImageView.kf.setImage(with: URL(string: EndPoint.imageURL + data.posterPath))
        nameLabel.text = data.title
    }
    
    private func callCastRequest() {
        guard let movieID = movieDetail?.id else { return }
        APIManager.shared.request(.credit(path: Int32(movieID)), responseType: CreditResponse.self) { result in
            switch result {
            case .success(let data):
                guard let castList = data.cast else { return }
                self.castList = castList
                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CreditViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Overview"
        case 1: return "Cast"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return castList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewCell.identifier, for: indexPath) as? OverviewCell else { return UITableViewCell() }
            
            cell.update(data: movieDetail?.overview)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.identifier, for: indexPath) as? CastCell else { return UITableViewCell() }
            
            cell.update(data: castList[indexPath.row])
            
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 130
        default:
            return UITableView.automaticDimension
        }
    }
}

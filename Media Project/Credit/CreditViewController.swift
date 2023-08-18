//
//  CreditViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/12/23.
//

import UIKit
import Kingfisher

final class CreditViewController: UIViewController {
    
    var contentsDetail: Contents?
    
    private var castList: [Cast] = []
    private var overviewIsOpened = false
    private lazy var goToSeriesVCButton = UIBarButtonItem(title: "Series", image: UIImage(systemName: "list.bullet.below.rectangle"), target: self, action: #selector(goToSeriesVC))
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if contentsDetail?.mediaType == .tv {
            navigationItem.rightBarButtonItem = goToSeriesVCButton
        }
        
        update(data: contentsDetail)
        callCastRequest(mediaType: contentsDetail?.mediaType)
    }
    
    private func update(data: Contents?) {
        guard let data else { return }
        
        backdropImageView.kf.setImage(with: data.backdropURL, placeholder: contentsPlaceholder)
        posterImageView.kf.setImage(with: data.posterURL, placeholder: contentsPlaceholder)
        nameLabel.text = data.title
    }
    
    private func callCastRequest(mediaType: MediaType?) {
        guard let mediaType else { return }
        guard let id = contentsDetail?.id else { return }

        var request: TMDBRequest {
            switch mediaType {
            case .movie:
                return .movieCredit(path: id)
            case .tv:
                return .tvCredit(path: id)
            }
        }
        
        APIManager.shared.request(request, responseType: CreditResponse.self) { [weak self] data in
            guard let castList = data.cast else { return }
            self?.castList = castList
        } onFailure: { error in
            print(error)
        }
    }
    
    @objc
    private func goToSeriesVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: SeriesViewController.identifier) as? SeriesViewController else { return }
        vc.id = contentsDetail?.id
        navigationController?.pushViewController(vc, animated: true)
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
            
            cell.update(data: contentsDetail?.overview, opened: overviewIsOpened)
            
            cell.overviewSectionReload = { [weak self] in
                self?.overviewIsOpened.toggle()
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
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
        case 1:
            return 130
        default:
            return UITableView.automaticDimension
        }
    }
}

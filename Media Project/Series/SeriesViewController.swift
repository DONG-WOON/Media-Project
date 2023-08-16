//
//  SeriesViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/16/23.
//

import UIKit
import Kingfisher

class SeriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var seasons: [Season] = [] { didSet {
        dump(seasons)
    }}
    var id: Int32?

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        callRequest() {
            
        }
    }
    
    func callRequest(completion: @escaping () -> Void) {
        guard let id else { return }
        
        APIManager.shared.request(.tvSeason(path: id), responseType: Contents.self) { [weak self] result in
            switch result {
            case .success(let contents):
                guard let self else { return }
                guard let seasons = contents.seasons else { return }
                self.seasons = seasons
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

extension SeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeriesCollectionReusableView.identifier, for: indexPath) as? HeaderSeriesCollectionReusableView else { return UICollectionReusableView() }
        view.update(data: seasons[indexPath.section])
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell() }
        
//        let path = seasons.posterPath
//        cell.imageView.kf.setImage(with: URL(string: EndPoint.imageURL + path))
        
        return cell
    }
}

extension SeriesViewController {
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = SeriesCompositionalLayout()
        
        collectionView.register(UINib(nibName: HeaderSeriesCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeriesCollectionReusableView.identifier)
        collectionView.register(UINib(nibName: SeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
    }
}

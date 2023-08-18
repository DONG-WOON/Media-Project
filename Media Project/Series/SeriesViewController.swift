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
    
    private let dispatchGroup = DispatchGroup()
    private var seasons: [Season] = []
    private var episodes: [[Episode]] = []
    private var lastSeasonNumber: Int?
    
    var id: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    
        dispatchGroup.enter()
        
        // ⭐️ Q: 데이터가 많을 경우 pagenation을 제공해야하지않을까? ⭐️
        self.callTVSeasonRequest() { seasons in
            for season in seasons {
                self.dispatchGroup.enter()
                self.callTVSeasonDetailRequest(seasonNumber: season.seasonNumber)
            }
        }
        
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    func callTVSeasonRequest(completion: @escaping ([Season]) -> Void) {
        guard let id else { return }
        
        DispatchQueue.global().async(group: dispatchGroup) {
            APIManager.shared.request(.tvSeason(path: id), responseType: Contents.self) { [weak self] result in
                switch result {
                case .success(let contents):
                    guard let self else { return }
                    guard let seasons = contents.seasons else { return }
                    let sortedSeasons = seasons.sorted(by: { $0.seasonNumber < $1.seasonNumber } )
                    self.seasons = sortedSeasons
                    completion(sortedSeasons)
                    self.dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func callTVSeasonDetailRequest(seasonNumber: Int) {
        guard let id else { return }
    
        DispatchQueue.global().async(group: dispatchGroup) {
            APIManager.shared.request(.tvSeasonDetail(id: id, seasonNumber: seasonNumber), responseType: Season.self) { [weak self] result in
                switch result {
                case .success(let season):
                    guard let self else { return }
                    guard let episodes = season.episodes else { return }
                    print("✅ ",seasonNumber)
                    self.episodes.append(episodes)
                    self.dispatchGroup.leave()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension SeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("🔥 ",section)
        return episodes[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeriesCollectionReusableView.identifier, for: indexPath) as? HeaderSeriesCollectionReusableView else { return UICollectionReusableView() }
        
        view.update(data: seasons[indexPath.section])
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell() }
        let episode = episodes[indexPath.section][indexPath.item]
        
        cell.update(data: episode)
        
        return cell
    }
}

extension SeriesViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //        for indexPath in indexPaths {
        //            callTVSeasonDetailRequest(seasonNumber: seasons[indexPath.section].seasonNumber)
        //        }
    }
}

extension SeriesViewController {
    private func setCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.collectionViewLayout = SeriesCompositionalLayout()
        
        collectionView.register(UINib(nibName: HeaderSeriesCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeriesCollectionReusableView.identifier)
        collectionView.register(UINib(nibName: SeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
    }
}

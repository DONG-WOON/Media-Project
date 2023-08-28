//
//  RecommendationViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/21/23.
//

import UIKit

class RecommendationViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmented: UISegmentedControl!
    
    enum RecommendationType: Int {
        case similar
        case video
    }
    
    var id: Int32?
    lazy var mediaType: MediaType = .movie
    
    private var videoList: [Video] = []
    private var similarContentsList: [Contents] = []
    private let dispatchGroup = DispatchGroup()
    private lazy var collectionViewReload = self.collectionView.reloadData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewLayout()
        configureCollectionView()
        
        addTargetToViews()
        dispatchInGroup()
    }
    
    func dispatchInGroup() {
        
        DispatchQueue.global().async(group: dispatchGroup) { [self] in
            guard let id else { return }
            
            callSimilarRequest(id: id, mediaType: mediaType)
            callVideoRequest(id: id, mediaType: mediaType)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionViewReload()
        }
    }
    
    @objc
    func changeSegmentedControl(_ sender: UISegmentedControl) {
        collectionViewReload()
    }
    
    func callSimilarRequest(id: Int32, mediaType: MediaType) {
        dispatchGroup.enter()
        
        var request: TMDBRequest {
            switch mediaType {
            case .movie:
                return .movieSimilar(path: id)
            case .tv:
                return .tvSimilar(path: id)
            }
        }
        
        APIManager.shared.request(request, responseType: SimilarResponse.self) { response in
            let contentsList = response.results
            self.similarContentsList = contentsList
            self.dispatchGroup.leave()
        } onFailure: { error in
            print(error)
        }
    }
    
    func callVideoRequest(id: Int32, mediaType: MediaType) {
        dispatchGroup.enter()
        var request: TMDBRequest {
            switch mediaType {
            case .movie:
                return .movieVideos(path: id)
            case .tv:
                return .tvVideos(path: id)
            }
        }
        APIManager.shared.request(request, responseType: VideoResponse.self) { response in
            let videoList = response.results
            self.videoList = videoList
            self.dispatchGroup.leave()
        } onFailure: { error in
            print(error)
        }
    }
}

extension RecommendationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmented.selectedSegmentIndex == 0 ? similarContentsList.count : videoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as? RecommendationCollectionViewCell else { return UICollectionViewCell() }
        
        guard let segment = RecommendationType(rawValue: segmented.selectedSegmentIndex) else { return UICollectionViewCell() }
        
        switch segment {
        case .similar:
            cell.update(data: similarContentsList[indexPath.item])
            return cell
        case .video:
            cell.update(data: videoList[indexPath.item])
            return cell
        }
    }
}

extension RecommendationViewController: CollectionViewConfigurable {
    func configureCollectionViewLayout() {
        collectionView.collectionViewLayout = RecommendationCompositionalLayout()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension RecommendationViewController {
    func addTargetToViews() {
        segmented.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
    }
}

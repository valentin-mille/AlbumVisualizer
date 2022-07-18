//
//  PhotoViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import Kingfisher
import RxCocoa
import RxSwift
import UIKit

class PhotoViewController: UIViewController {
    // MARK: - @IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties

    private let photoService = PhotoService()
    private let bag = DisposeBag()
    private let edges = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private var selectedPhoto: Photo?
    var album: Album!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        bind()
    }

    private func prepareUI() {
        title = "Photos"
        collectionView.refreshControl = UIRefreshControl()
    }

    private func bind() {
        let reload = collectionView.refreshControl!.rx.controlEvent(.valueChanged).asObservable()
        let photos = reload.flatMap { [unowned self] _ in
            self.photoService.getPhotos(params: PhotoParams(albumId: self.album.id, page: 1)).catch { error in
                self.presentAlert(message: error.localizedDescription)
                return .empty()
            }
        }.do(onNext: { _ in
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }
        })

        photos.bind(to: collectionView.rx.items(
            cellIdentifier: PhotoCollectionViewCell.identifier,
            cellType: PhotoCollectionViewCell.self)) { _, photo, cell in
                cell.setupView(imageURL: photo.thumbnailUrl, title: photo.title)
            }.disposed(by: bag)

        collectionView.rx.modelSelected(Photo.self).subscribe(onNext: { [weak self] in
            self?.selectedPhoto = $0
            self?.performSegue(withIdentifier: StoryboardSegue.Photos.goToDetail.rawValue, sender: self)
        }).disposed(by: bag)

        collectionView.refreshControl?.sendActions(for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == StoryboardSegue.Photos.goToDetail.rawValue {
            if let detailVC = segue.destination as? PhotoDetailViewController {
                detailVC.photo = selectedPhoto
            }
        }
    }
}

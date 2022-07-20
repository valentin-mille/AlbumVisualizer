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
    private var photos: Observable<[Photo]> = .empty()
    private var refreshController = UIRefreshControl()
    var album: Album!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        bind()
    }

    // MARK: - Methods

    private func prepareUI() {
        title = Strings.Photo.title
        collectionView.refreshControl = refreshController
    }

    private func bind() {
        let reload = refreshController.rx.controlEvent(.valueChanged).asObservable()
        photos = reload.flatMap { [unowned self] _ in
            self.photoService.getPhotos(params: PhotoParams(albumId: self.album.id, page: 1)).catch { error in
                self.presentNetworkAlert()
                self.endRefreshing()
                return .just(CoreDataManager.shared.fetchPhotoConverted(album: self.album))
            }
        }.do(onNext: { photos in
            DispatchQueue.main.async {
                for photo in photos {
                    CoreDataManager.shared.insertPhoto(toInsert: photo)
                }
            }
            self.endRefreshing()
        }, onError: { _ in
            self.endRefreshing()
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

        refreshController.sendActions(for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == StoryboardSegue.Photos.goToDetail.rawValue {
            if let detailVC = segue.destination as? PhotoDetailViewController {
                detailVC.photo = selectedPhoto
            }
        }
    }

    private func endRefreshing() {
        DispatchQueue.main.async {
            if self.refreshController.isRefreshing {
                self.refreshController.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
}

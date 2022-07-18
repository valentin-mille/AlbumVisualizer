//
//  AlbumViewController.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import RxCocoa
import RxSwift
import UIKit

class AlbumViewController: UIViewController {
    // MARK: - @IBOutlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    private let userDefaults = UserDefaults.standard
    private let albumServices = AlbumService()
    private let bag = DisposeBag()
    private var selectedAlbum: Album?

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayOnBoarding()

        // Remove selected cell when back to ViewController
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Methods

    private func prepareUI() {
        title = Strings.Album.title

        tableView.refreshControl = UIRefreshControl()
    }

    private func bind() {
        let reload = tableView.refreshControl!.rx.controlEvent(.valueChanged).asObservable()
        let albums = reload.flatMap { [unowned self] _ in
            self.albumServices.getAlbums().observe(on: MainScheduler.instance).catch { error in
                self.presentAlert(message: error.localizedDescription)
                self.endRefreshing()
                return .empty()
            }
        }.do(onNext: { _ in
            self.endRefreshing()
        })

        albums
            .bind(
                to: tableView.rx
                    .items(cellIdentifier: "AlbumCell", cellType: UITableViewCell.self)) { _, album, cell in
                cell.textLabel?.text = album.title.capitalized
            }.disposed(by: bag)

        tableView.rx.modelSelected(Album.self)
            .subscribe(onNext: { [weak self] in
                self?.selectedAlbum = $0
                self?.performSegue(withIdentifier: StoryboardSegue.Album.goToPhotos.rawValue, sender: self)
            })
            .disposed(by: bag)

        tableView.refreshControl?.sendActions(for: .valueChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == StoryboardSegue.Album.goToPhotos.rawValue {
            if let photosVC = segue.destination as? PhotoViewController {
                photosVC.album = selectedAlbum
            }
        }
    }

    private func displayOnBoarding() {
        DispatchQueue.main.async {
            if !self.userDefaults.onBoardingHasBeenShown {
                self.present(StoryboardScene.OnBoarding.initialScene.instantiate(), animated: true)
            }
        }
    }

    private func endRefreshing() {
        if tableView.refreshControl!.isRefreshing {
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}

//
//  PhotosListViewController.swift
//  PhotosList
//
//  Created by Azza on 07/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosListViewController: UIViewController, UIScrollViewDelegate, Loadable {

    @IBOutlet weak var photosTableView: UITableView!
    
    private let viewModel = PhotosListViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.fetchData()
    }
    
    private func updateUI() {
        title = "Photos"
        setupTableView()
        configureBinding()
        bindViewModel()
    }
    
    private func setupTableView() {
        photosTableView.register(PhotoTableViewCell.nib, forCellReuseIdentifier: PhotoTableViewCell.reuseIdentifier)
        photosTableView.register(AdPlaceholderCell.nib, forCellReuseIdentifier: AdPlaceholderCell.reuseIdentifier)
        photosTableView.rowHeight = 250
        photosTableView.prefetchDataSource = self
    }
    
    //MARK:- Bindings
    private func configureBinding() {
        photosTableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        photosTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                guard let self = self, ((index.row + 1) % 6 != 0) else { return }
                self.navigateToPhotoDetails(with: index.row)
            }).disposed(by: bag)
        
        viewModel.showLoader
                    .asDriver(onErrorJustReturn: false)
                    .drive(onNext: { [weak self]  in
                        self?.showLoading(show: $0)
                    }).disposed(by: bag)
    }
    
    private func bindViewModel() {
        viewModel.photosListSubject
            .bind(to: photosTableView.rx.items) { (tableView, row, photoItem) in
                let indexPath = IndexPath(row: row, section: 0)
                if (row + 1) % 6 == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier:AdPlaceholderCell.reuseIdentifier, for: indexPath) as! AdPlaceholderCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier:PhotoTableViewCell.reuseIdentifier, for: indexPath) as! PhotoTableViewCell
                    cell.setupUiWithData(photoItem: photoItem)
                    return cell
                }
            }.disposed(by: bag)
        
        viewModel.error.subscribe(onNext: { [weak self] erro in
            let alert = UIAlertController(title: "Alert", message: erro, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: bag)
        
    }
    
    private func navigateToPhotoDetails(with index: Int) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "PhotoDetailsViewController") as? PhotoDetailsViewController else { return }
        guard let photo = try? viewModel.photosListSubject.value[index] else { return }
        let photoDetailsInfoModel = PhotoDetailsViewInfo(authorName: photo.author, photoImageURL: URL(string: photo.downloadURL))
        let detailViewModel = PhotoDetailsViewModel(photoDetailsViewInfo: photoDetailsInfoModel)
        viewController.viewModel = detailViewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension PhotosListViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.prefetchItemsAt(indexPaths: indexPaths)
    }
}


//
//  PhotosListViewController.swift
//  PhotosList
//
//  Created by Azza on 07/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosListViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photosTableView: UITableView!
    
    private let viewModel = PhotosListViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureBinding()
        bindViewModel()
    }
    
    private func setupTableView() {
        photosTableView.register(PhotoTableViewCell.nib, forCellReuseIdentifier: PhotoTableViewCell.reuseIdentifier)
        photosTableView.register(AdPlaceholderCell.nib, forCellReuseIdentifier: AdPlaceholderCell.reuseIdentifier)
        photosTableView.rowHeight = 250
    }
    
    //MARK:- Bindings
    private func configureBinding() {
        photosTableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        photosTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                guard let self = self, ((index.row + 1) % 6 != 0) else { return }
                self.navigateToPhotoDetails(index: index.row)
            }).disposed(by: bag)

    }
    
    private func bindViewModel() {
        viewModel.photosList
            .bind(to: photosTableView.rx.items) { (tableView, row, photoItem) in
                let indexPath = IndexPath(row: row, section: 0)
                if (row + 1) % 6 == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier:AdPlaceholderCell.reuseIdentifier, for: indexPath) as! AdPlaceholderCell
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier:PhotoTableViewCell.reuseIdentifier, for: indexPath) as! PhotoTableViewCell
                    cell.setupUiWithData(photoItem: photoItem)
                    return cell
                }
            }.disposed(by: bag)
        
    }
    
    private func navigateToPhotoDetails(index: Int) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "PhotoDetailsViewController") as? PhotoDetailsViewController else { return }
        let photoDetailsViewInfo = viewModel.getPhotoDetailsViewInfo(at: index)
        let detailViewModel = PhotoDetailsViewModel(photoDetailsViewInfo: photoDetailsViewInfo)
        viewController.viewModel = detailViewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


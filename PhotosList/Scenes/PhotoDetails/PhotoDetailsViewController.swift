//
//  PhotoDetailsViewController.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var viewModel = PhotoDetailsViewModel(photoDetailsViewInfo: .init(authorName: "", photoImageURL: nil))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

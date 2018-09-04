//
//  GallaryViewController.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/2/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ALCameraViewController

class GallaryViewController: BaseViewController {
    fileprivate var viewModel: GallaryViewModel?
    fileprivate var router: GallaryRouter?
    fileprivate let disposeBag = DisposeBag()

    var libraryEnabled: Bool = true
    var croppingEnabled: Bool = false
    var allowResizing: Bool = true
    var allowMoving: Bool = false
    var minimumSize: CGSize = CGSize(width: 60, height: 60)
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var croppingParameters: CroppingParameters {
        return CroppingParameters(isEnabled: croppingEnabled, allowResizing: allowResizing, allowMoving: allowMoving, minimumSize: minimumSize)
    }
    
    init(withViewModel viewModel: GallaryViewModel, router: GallaryRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GallaryViewModel()

        setupViews()
        setupLayout()
        setupRx()
    }
    @IBAction func openLib(_ sender: UIBarButtonItem) {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingParameters) { [weak self] image, asset in
            //self?.imageView.image = image
            if let uploadedImage =  image{
                self?.upload(image: uploadedImage)
            }
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(libraryViewController, animated: true, completion: nil)
    }
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
        let cameraViewController = CameraViewController(croppingParameters: croppingParameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, asset in
            if let uploadedImage = image{
                self?.upload(image: uploadedImage)
            }
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(cameraViewController, animated: true, completion: nil)
    }
    
    func upload(image:UIImage) {
        self.viewModel?.upload(image: image)
    }
}

// MARK: Setup
private extension GallaryViewController {

    func setupViews() {
        photoCollectionView.addSubview(activity)

        photoCollectionView?.delegate = nil
        photoCollectionView?.rx.setDelegate(self).disposed(by: disposeBag)
    viewModel?.photosRX.asObservable().share().bind(to: photoCollectionView!.rx.items(cellIdentifier: PhotoCollectionViewCell.id, cellType: PhotoCollectionViewCell.self)) { row, cellData, cell in
            
        cell.configureCellWith(photo: cellData)
        
            }.disposed(by: disposeBag)
        viewModel?.loading.asObservable().bind(to: activity.rx_animating).disposed(by: disposeBag)

        
    }

    func setupLayout() {
    
    }

    func setupRx() {
    
    }
}

extension GallaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 2.2
        let height = width /*/ 0.76*/
        return CGSize(width: width, height: height)
    }
}

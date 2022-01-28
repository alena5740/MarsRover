//
//  MarsPhotoViewController.swift
//  MarsRover
//
//  Created by Алена on 12.10.2021.
//

import UIKit

final class MarsPhotoViewController: UIViewController {
    
    private let marsPhotoView = MarsPhotoView()
    private let networkSevice = NetworkService()
    
    var model: Model?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorBeige
        networkSevice.delegatNetworkService = self
        setupMarsPhotoView()
        marsPhotoView.configure(model: self.model!)
    }
    
    private func setupMarsPhotoView() {
        view.addSubview(marsPhotoView)
        marsPhotoView.frame = self.view.frame
    }
}
    
extension MarsPhotoViewController: NetworkServiceProtocol {
    func updateInterface(_: NetworkService, with model: Model) {
        marsPhotoView.configure(model: model)
    }
}

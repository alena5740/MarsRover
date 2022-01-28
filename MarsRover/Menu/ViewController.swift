//
//  ViewController.swift
//  MarsRover
//
//  Created by Алена on 12.10.2021.
//

import UIKit

@objc protocol ViewControllerProtocol: AnyObject {
    @objc func pushToMarsPhotoViewController()
    func textFieldParametr(date: String) 
}

final class ViewController: UIViewController {
    
    private let menuView = MenuView()
    private let networkSevice = NetworkService()
    private let pickerView = UIPickerView()
    private let marsRoverNames = ["Fhaz", "Rhaz", "Mast", "Chemcam", "Mahli", "Mardi", "Navcam", "Pancam", "Minites"]
    
    private var dateEarth = ""
    private var cameraName = ""

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
        setupPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        menuView.delegatViewController = self
    }
    
    private func setupMenuView() {
        view.addSubview(menuView)
        menuView.frame = self.view.frame
    }
    
    private func makeConstraintsPickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: boundsDevices.height / 1.45),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (boundsDevices.width - (boundsDevices.width / 1.5)) / 2),
            pickerView.widthAnchor.constraint(equalToConstant: boundsDevices.width / 1.5),
            pickerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.backgroundColor = colorBeige
        pickerView.layer.cornerRadius = 15
        makeConstraintsPickerView()
    }
}

extension ViewController: ViewControllerProtocol {
    func textFieldParametr(date: String) {
        dateEarth = date
    }
    
    @objc func pushToMarsPhotoViewController() {
        menuView.configure()
        networkSevice.getData(earthDate: dateEarth, camera: cameraName, completion: { model in
            let marsPhotoViewController = MarsPhotoViewController()
            marsPhotoViewController.model = model
            
            if model.imageMars == nil {
                let alertController = UIAlertController(title: "Упс, ничего нет...", message: "Попробуйте другую дату или марсоход", preferredStyle: .alert)
                let action = UIAlertAction(title: "Окей", style: .default, handler: nil)
                
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            self.navigationController?.pushViewController(marsPhotoViewController, animated: false)
        })
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return marsRoverNames.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return marsRoverNames[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cameraName = marsRoverNames[row]
    }
}



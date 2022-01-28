//
//  MenuView.swift
//  MarsRover
//
//  Created by Алена on 12.10.2021.
//

import UIKit

final class MenuView: UIView {
    private let scrollView = UIScrollView()
    private let imageMenu = UIImageView()
    private let labelDate = UILabel()
    private let textFieldDate = UITextField()
    private let labelCameraName = UILabel()
    private let buttonPushPhotoViewController = UIButton()
    
    weak var delegatViewController: ViewControllerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageMenu()
        setupLabelCameraName()
        setupButtonPushPhotoViewController()
        setupScrollView()
        setupLabelDate()
        setupTextFieldDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraintsScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: boundsDevices.width, height: boundsDevices.height)
    }
    
    private func setupScrollView() {
        scrollView.addSubview(labelDate)
        scrollView.addSubview(textFieldDate)
        self.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        makeConstraintsScrollView()
    }
    
    private func makeConstraintsImageMenu() {
        imageMenu.frame = CGRect(x: 0, y: 0, width: boundsDevices.width, height: boundsDevices.height)
    }

    private func setupImageMenu() {
        self.addSubview(imageMenu)
        imageMenu.image = UIImage(named: "mars.jpg")
        makeConstraintsImageMenu()
        imageMenu.contentMode = .scaleAspectFill
    }
    
    private func makeConstraintsLabelDate() {
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 1.7) - 30),
            labelDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width - (boundsDevices.width / 1.5)) / 2),
            labelDate.widthAnchor.constraint(equalToConstant: boundsDevices.width / 1.5),
            labelDate.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupLabelDate() {
        labelDate.text = "Введите земную дату"
        labelDate.backgroundColor = .clear
        labelDate.textColor = .white
        labelDate.textAlignment = .center
        makeConstraintsLabelDate()
    }
    
    private func makeConstraintsTextFieldDate() {
        textFieldDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldDate.topAnchor.constraint(equalTo: self.topAnchor, constant: boundsDevices.height / 1.7),
            textFieldDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width - (boundsDevices.width / 1.5)) / 2),
            textFieldDate.widthAnchor.constraint(equalToConstant: boundsDevices.width / 1.5),
            textFieldDate.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTextFieldDate() {
        textFieldDate.backgroundColor = colorBeige
        textFieldDate.layer.cornerRadius = 15
        textFieldDate.placeholder = "2020-06-03"
        textFieldDate.textAlignment = .center
        textFieldDate.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        textFieldDate.textColor = .darkGray
        makeConstraintsTextFieldDate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    private func makeConstraintsLabelCameraName() {
        labelCameraName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelCameraName.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 1.45) - 30),
            labelCameraName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width - (boundsDevices.width / 1.5)) / 2),
            labelCameraName.widthAnchor.constraint(equalToConstant: boundsDevices.width / 1.5),
            labelCameraName.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupLabelCameraName() {
        self.addSubview(labelCameraName)
        labelCameraName.text = "Выберите имя марсохода"
        labelCameraName.backgroundColor = .clear
        labelCameraName.textColor = .white
        labelCameraName.textAlignment = .center
        makeConstraintsLabelCameraName()
    }
    
    private func makeConstraintsButtonPushPhotoViewController() {
        buttonPushPhotoViewController.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonPushPhotoViewController.topAnchor.constraint(equalTo: self.topAnchor, constant: boundsDevices.height / 1.25),
            buttonPushPhotoViewController.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width - (boundsDevices.width / 1.5)) / 2),
            buttonPushPhotoViewController.widthAnchor.constraint(equalToConstant: boundsDevices.width / 1.5),
            buttonPushPhotoViewController.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupButtonPushPhotoViewController() {
        self.addSubview(buttonPushPhotoViewController)
        buttonPushPhotoViewController.backgroundColor = UIColor(red: 57/255, green: 35/255, blue: 21/255, alpha: 1)
        buttonPushPhotoViewController.layer.cornerRadius = 15
        buttonPushPhotoViewController.setTitle("Покажите Марс!", for: .normal)
        buttonPushPhotoViewController.setTitleColor(.white, for: .normal)
        buttonPushPhotoViewController.addTarget(delegatViewController, action: #selector(self.delegatViewController?.pushToMarsPhotoViewController), for: .touchDown)
        makeConstraintsButtonPushPhotoViewController()
    }
    
    func configure() {
        if let date = textFieldDate.text {
            delegatViewController?.textFieldParametr(date: date)
        }
    }
}

extension MenuView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
}

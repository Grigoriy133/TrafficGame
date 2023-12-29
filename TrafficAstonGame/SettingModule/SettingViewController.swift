//
//  SettingViewController.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 24.12.2023.
//

import UIKit

class SettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let settingView = SettingView()
    var currentLevelNumber = 0
    var currentColor = 0
    var model = settingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingView
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        configurateButtons()
        setupImageViewTap()
        setupUserInformation()
    }
    
    private func configurateButtons(){
        settingView.upButton.addTarget(self, action: #selector(upGameLevel), for: .touchUpInside)
        settingView.downButton.addTarget(self, action: #selector(downGameLevel), for: .touchUpInside)
        settingView.leftButton.addTarget(self, action: #selector(upColor), for: .touchUpInside)
        settingView.rightButton.addTarget(self, action: #selector(downColor), for: .touchUpInside)
    }
    
    @objc private func upGameLevel(){
        if currentLevelNumber < model.levelsArray.count - 1 {
            currentLevelNumber += 1
            memoryServices.shared.saveLevel(model.levelsArray[currentLevelNumber])
        } else {
            currentLevelNumber = 0
            memoryServices.shared.saveLevel(model.levelsArray[currentLevelNumber])
        }
        settingView.gameLevelLabel.text = model.levelsArray[currentLevelNumber]
    }
    @objc private func downGameLevel(){
        if currentLevelNumber > 0 {
            currentLevelNumber -= 1
            memoryServices.shared.saveLevel(model.levelsArray[currentLevelNumber])
        } else {
            currentLevelNumber = model.levelsArray.count - 1
            memoryServices.shared.saveLevel(model.levelsArray[currentLevelNumber])
        }
        settingView.gameLevelLabel.text = model.levelsArray[currentLevelNumber]
    }
    @objc private func upColor(){
        if currentColor < model.colorArray.count - 1 {
            currentColor += 1
            memoryServices.shared.saveColor(model.colorArray[currentColor])
        } else {
            currentColor = 0
            memoryServices.shared.saveColor(model.colorArray[currentColor])
        }
        settingView.carView.backgroundColor = model.colorArray[currentColor]
    }
    @objc private func downColor(){
        if currentColor > 0 {
            currentColor -= 1
            memoryServices.shared.saveColor(model.colorArray[currentColor])
        } else {
            currentColor = model.colorArray.count - 1
            memoryServices.shared.saveColor(model.colorArray[currentColor])
        }
        settingView.carView.backgroundColor = model.colorArray[currentColor]
    }
}

//MARK: Configurate Image
extension SettingViewController {
    func setupImageViewTap() {
           let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        settingView.userPhoto.isUserInteractionEnabled = true
        settingView.userPhoto.addGestureRecognizer(tapGestureRecognizer)
       }
       
       @objc func handleTap(_ sender: UITapGestureRecognizer) {
           let alertController = UIAlertController(title: "Select a photo", message: "Source", preferredStyle: .actionSheet)
           let cameraAction = UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
               self.presentImagePicker(sourceType: .camera)
           }
           let photoLibraryAction = UIAlertAction(title: "Gallery", style: .default) { [unowned self] _ in
               self.presentImagePicker(sourceType: .photoLibrary)
           }
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               alertController.addAction(cameraAction)
           }
           alertController.addAction(photoLibraryAction)
           alertController.addAction(cancelAction)
           
           present(alertController, animated: true, completion: nil)
       }
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            present(imagePicker, animated: true, completion: nil)
        }
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            
        settingView.userPhoto.image = selectedImage
        memoryServices.shared.saveImage(image: settingView.userPhoto.image ?? UIImage())
            dismiss(animated: true, completion: nil)
        }
    private func setupUserInformation(){
        settingView.userPhoto.image = memoryServices.shared.loadImages()
        settingView.userNameLabel.text = GameSettings.shared.currentUser
    }
}

//
//  EnterLicenseInfoViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/15/24.
//

import UIKit

final class EnterLicenseInfoViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = EnterLicenseInfoView()
    private let regionData: [RegionModel] = RegionModel.dummy()
    private let regionText: [String] = RegionModel.fetchDummyForText()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        hideKeyboard(forDelegate: self)
        
        setupDelegate()
        setupTarget()
    }
}

extension EnterLicenseInfoViewController {
    
    // MARK: - Private Method
    
    private func setupDelegate() {
        rootView.setTextFieldDelegate(self)
    }
    
    private func setupTarget() {
        rootView.setupClearButton(action: clearButtonTapped)
        rootView.setupregisterLicenseButton(action: registerLicenseButtonTapped)
        rootView.setupCameraButton(action: cameraButtonTapped)
        rootView.setupShowPickerButton(action: showPickerButtonTapped)
        rootView.setPickerViewDelegate(self)
    }
    
    private func postLiseceValid() {
        let licenseNumber = rootView.licenseNumberTextField.text ?? ""
        let licenseNo01Text = regionData[self.rootView.regionPickerView.selectedRow(inComponent: 0)].regionNumber
        let licenseNo02Text: String
        let licenseNo03Text: String
        let licenseNo04Text: String
        let biethDateText = rootView.socialSecurityNumberFirstTextField.text ?? ""
        let serialNumber = rootView.serialNumberTextField.text ?? ""
        let nameText = rootView.nameTextField.text ?? ""

        let firstRange = licenseNumber.startIndex..<licenseNumber.index(licenseNumber.startIndex, offsetBy: 2)
        let secondRange = licenseNumber.index(licenseNumber.startIndex, offsetBy: 2)..<licenseNumber.index(licenseNumber.startIndex, offsetBy: 8)
        let thirdRange = licenseNumber.index(licenseNumber.startIndex, offsetBy: 8)..<licenseNumber.endIndex
        
        licenseNo02Text = String(licenseNumber[firstRange])
        licenseNo03Text = String(licenseNumber[secondRange])
        licenseNo04Text = String(licenseNumber[thirdRange])
        
        let request = LisenceValidRequestDTO(birthDate: biethDateText, licenseNo01: licenseNo01Text, licenseNo02: licenseNo02Text, licenseNo03: licenseNo03Text, licenseNo04: licenseNo04Text, serialNo: serialNumber, userName: nameText)
        
        LicenseAPIService.shared.postLisenceValid(request: request) { response in
            switch response {
            case .success(let data):
                print("아아아아아아아")
            default:
                break
            }
        }
    }
    
    private func postLisenceOCR(imageData: Data) {
        LicenseAPIService.shared.postLisenceOCR(imageData: imageData) { response in
            switch response {
            case .success(let data):
                print("아아아아아아아")
            default:
                break
            }
        }
    }
    
    private func takePhoto() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            } else {
                print("카메라 사용 불가능")
            }
        }
    
    private func showPickerButtonTapped() {
        print("showPickerButtonTapped")
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(rootView.regionPickerView)
        rootView.regionPickerView.frame = CGRect(x: 0, y: 0, width: alert.view.bounds.width, height: 180.0)
        
        let doneAction = UIAlertAction(title: "선택", style: .default) { (action) in
            let selectedValue = self.regionText[self.rootView.regionPickerView.selectedRow(inComponent: 0)]
            self.rootView.regionTextField.text = selectedValue
        }
        alert.addAction(doneAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func clearButtonTapped(_ button: UIButton) {
        switch button.tag {
        case 1:
            rootView.setTextFieldInitialState(textFieldTag: 1)
        case 2:
            rootView.setTextFieldInitialState(textFieldTag: 2)
        case 3:
            rootView.setTextFieldInitialState(textFieldTag: 3)
        case 4:
            rootView.setTextFieldInitialState(textFieldTag: 4)
        default:
            return
        }
    }
    
    private func cameraButtonTapped() {
        print("cameraButtonTapped")
        takePhoto()
    }

    private func registerLicenseButtonTapped() {
        print("registerLicenseButtonTapped")
        postLiseceValid()
    }
}

extension EnterLicenseInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowColor = UIColor.lawingGray3.cgColor
        
        rootView.setLabelTextColor(textFieldTag: textField.tag, isEditing: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let text = textField.text ?? ""
        
        if textField.tag != 0 { textField.rightViewMode = .never }
        
        if text.isEmpty {
            textField.layer.shadowColor = UIColor.lawingGray1.cgColor
            
            rootView.setLabelTextColor(textFieldTag: textField.tag, isEditing: false)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""

        if text.isEmpty {
            if textField.tag != 0 { textField.rightViewMode = .never }
        } else {
            textField.rightViewMode = .always
        }
    }
}

extension EnterLicenseInfoViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regionText.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionText[row]
    }
}

extension EnterLicenseInfoViewController: UIPickerViewDataSource {
    
}

extension EnterLicenseInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        return true
    }
}

extension EnterLicenseInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        if let imageData = image.jpegData(compressionQuality: 1.0, maxSize: 512_000) {
            postLisenceOCR(imageData: imageData)
        }
    }
}

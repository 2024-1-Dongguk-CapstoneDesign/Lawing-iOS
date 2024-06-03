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
    
    private let regionData: [String] = RegionModel.fetchDummyForText()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
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
    
    private func showPickerButtonTapped() {
        print("showPickerButtonTapped")
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(rootView.regionPickerView)
        rootView.regionPickerView.frame = CGRect(x: 0, y: 0, width: alert.view.bounds.width, height: 180.0)
        
        
        let doneAction = UIAlertAction(title: "선택", style: .default) { (action) in
            let selectedValue = self.regionData[self.rootView.regionPickerView.selectedRow(inComponent: 0)]
            self.rootView.regionTextField.text = selectedValue
        }
        alert.addAction(doneAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func clearButtonTapped(_ button: UIButton) {
        switch button.tag {
        case 1:
            rootView.setTextFieldInitialState(textFieldTag: 0)
        case 2:
            rootView.setTextFieldInitialState(textFieldTag: 1)
        case 3:
            rootView.setTextFieldInitialState(textFieldTag: 2)
        case 4:
            rootView.setTextFieldInitialState(textFieldTag: 3)
        default:
            return
        }
    }
    
    private func cameraButtonTapped() {
        print("cameraButtonTapped")
    }

    private func registerLicenseButtonTapped() {
        print("registerLicenseButtonTapped")
    }
}

extension EnterLicenseInfoViewController: UITextFieldDelegate {
    
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
        return regionData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionData[row]
    }
}

extension EnterLicenseInfoViewController: UIPickerViewDataSource {
    
}

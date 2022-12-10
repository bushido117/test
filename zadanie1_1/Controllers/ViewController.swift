//
//  ViewController.swift
//  zadanie1_1
//
//  Created by Вадим Сайко on 8.12.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private enum Languages: String, CaseIterable {
            case english = "language_english"
            case russian = "language_russian"
            case belarusian = "language_belarusian"
        
            var languageSystemName: String {
                switch self {
                case .english:
                    return "en"
                case .russian:
                    return "ru"
                case .belarusian:
                    return "be"
            }
        }
    }
    private let containerView = ContainerView()
    private lazy var languagePicker = containerView.languagePicker
    private lazy var keyWindow = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.frame = UIScreen.main.bounds
        languagePicker.delegate = self
        languagePicker.dataSource = self
        view.addSubview(containerView)
        containerView.onDarkThemeButtonTapped = { [weak self] in
            self?.darkThemeButtonTapped()
        }
        containerView.onLightThemeButtonTapped = { [weak self] in
            self?.lightThemeButtonTapped()
        }
        containerView.onAutoThemeButtonTapped = { [weak self] in
            self?.autoThemeButtonTapped()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pickerViewSelectRow(for: languagePicker)
    }
    
    func pickerViewSelectRow(for pickerView: UIPickerView) {
        let row: Int = {
            switch AppLanguage.currentLanguage() {
            case Languages.allCases[0].languageSystemName:
                return 0
            case Languages.allCases[1].languageSystemName:
                return 1
            case Languages.allCases[2].languageSystemName:
                return 2
            default:
                return 0
            }
        }()
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    func refreshVC() {
        let vc = ViewController()
        keyWindow?.rootViewController = vc
        keyWindow?.backgroundColor = .systemBackground
    }
    
//MARK: Buttons Actions
    func darkThemeButtonTapped() {
        keyWindow?.overrideUserInterfaceStyle = .dark
        UserDefaults.standard.set("dark", forKey: "UserInterfaceStyle")
    }
    
    func lightThemeButtonTapped() {
        keyWindow?.overrideUserInterfaceStyle = .light
        UserDefaults.standard.set("light", forKey: "UserInterfaceStyle")
    }

    func autoThemeButtonTapped() {
        keyWindow?.overrideUserInterfaceStyle = .unspecified
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        NSLocalizedString(Languages.allCases[row].rawValue, comment: "")
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            AppLanguage.setNewLanguage( Languages.allCases[row].languageSystemName)
        case 1:
            AppLanguage.setNewLanguage(Languages.allCases[row].languageSystemName)
        case 2:
            AppLanguage.setNewLanguage(Languages.allCases[row].languageSystemName)
        default:
            break
        }
        refreshVC()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        30
    }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Languages.allCases.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

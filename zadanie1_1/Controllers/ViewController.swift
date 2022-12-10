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
    
    private lazy var keyWindow = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }
    
    private let imageView = UIImageView()
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let darkThemeButton: UIButton = {
        let button = UIButton()
        button.configuration = .bordered()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let lightThemeButton: UIButton = {
        let button = UIButton()
        button.configuration = .bordered()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let autoThemeButton: UIButton = {
        let button = UIButton()
        button.configuration = .bordered()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let iconName = "icon"
    private let languagePicker = UIPickerView()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()

    private let darkThemeButtonTitle = NSLocalizedString("button_dark", comment: "")
    private let lightThemeButtonTitile = NSLocalizedString("button_light", comment: "")
    private let autoThemeButtonTitile = NSLocalizedString("button_auto", comment: "")
    private let labelText = NSLocalizedString("label_greetings", comment: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
        
        imageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        
        greetingLabel.text = labelText
        
        darkThemeButton.addTarget(self, action: #selector(darkThemeButtonTapped), for: .touchUpInside)
        darkThemeButton.setTitle(darkThemeButtonTitle, for: .normal)
        
        lightThemeButton.addTarget(self, action: #selector(lightThemeButtonTapped), for: .touchUpInside)
        lightThemeButton.setTitle(lightThemeButtonTitile, for: .normal)

        autoThemeButton.addTarget(self, action: #selector(autoThemeButtonTapped), for: .touchUpInside)
        autoThemeButton.setTitle(autoThemeButtonTitile, for: .normal)

        addSubviews()
        makeConstraints()
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
        languagePicker.selectRow(row, inComponent: 0, animated: false)
    }
    
    func addSubviews() {
        view.addSubview(languagePicker)
        view.addSubview(imageView)
        view.addSubview(greetingLabel)
        view.addSubview(darkThemeButton)
        view.addSubview(lightThemeButton)
        view.addSubview(autoThemeButton)
        buttonsStackView.addArrangedSubview(lightThemeButton)
        buttonsStackView.addArrangedSubview(autoThemeButton)
        buttonsStackView.addArrangedSubview(darkThemeButton)
        view.addSubview(buttonsStackView)
    }
    
    func makeConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        greetingLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        languagePicker.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(220)
        }
        super.updateViewConstraints()
    }

    @objc func darkThemeButtonTapped() {
        keyWindow?.overrideUserInterfaceStyle = .dark
        UserDefaults.standard.set("dark", forKey: "UserInterfaceStyle")
    }
    
    @objc func lightThemeButtonTapped() {
        keyWindow?.overrideUserInterfaceStyle = .light
        UserDefaults.standard.set("light", forKey: "UserInterfaceStyle")
    }

    @objc func autoThemeButtonTapped() {
        keyWindow?.overrideUserInterfaceStyle = .unspecified
        UserDefaults.standard.set("auto", forKey: "UserInterfaceStyle")
    }
    
    func refreshVC() {
        let vc = ViewController()
        keyWindow?.rootViewController = vc
        keyWindow?.backgroundColor = .systemBackground
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

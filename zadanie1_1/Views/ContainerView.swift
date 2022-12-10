//
//  ContainerView.swift
//  zadanie1_1
//
//  Created by Вадим Сайко on 10.12.22.
//

import UIKit

class ContainerView: UIView {
    
    let languagePicker = UIPickerView()
    private let imageView = UIImageView()
    private let iconName = "icon"
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
    var onDarkThemeButtonTapped: (()-> Void)?
    var onLightThemeButtonTapped: (()-> Void)?
    var onAutoThemeButtonTapped: (()-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        darkThemeButton.setTitle(darkThemeButtonTitle, for: .normal)
        lightThemeButton.setTitle(lightThemeButtonTitile, for: .normal)
        autoThemeButton.setTitle(autoThemeButtonTitile, for: .normal)
        greetingLabel.text = labelText
        imageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        addTargets()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargets() {
        darkThemeButton.addTarget(self, action: #selector(darkThemeButtonTapped), for: .touchUpInside)
        lightThemeButton.addTarget(self, action: #selector(lightThemeButtonTapped), for: .touchUpInside)
        autoThemeButton.addTarget(self, action: #selector(autoThemeButtonTapped), for: .touchUpInside)
    }
    
    func setupSubviews() {
        self.addSubview(darkThemeButton)
        self.addSubview(lightThemeButton)
        self.addSubview(autoThemeButton)
        self.addSubview(greetingLabel)
        self.addSubview(imageView)
        self.addSubview(languagePicker)
        buttonsStackView.addArrangedSubview(lightThemeButton)
        buttonsStackView.addArrangedSubview(autoThemeButton)
        buttonsStackView.addArrangedSubview(darkThemeButton)
        self.addSubview(buttonsStackView)
    }
    
    func setupConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        greetingLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        languagePicker.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(220)
        }
    }
    
    @objc func darkThemeButtonTapped() {
        onDarkThemeButtonTapped?()
    }
    
    @objc func lightThemeButtonTapped() {
        onLightThemeButtonTapped?()
    }

    @objc func autoThemeButtonTapped() {
        onAutoThemeButtonTapped?()
    }
}

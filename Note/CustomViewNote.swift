//
//  new.swift
//  Note
//
//  Created by Kirill  Kostenko  on 10.02.2023.
//

import UIKit

class CustomViewNote:UIViewController{
    
    
    private lazy var textField:UITextView = {
        let text = UITextView()
        text.textAlignment = .left
        text.textColor = .black
        text.tag = 0
        //text.delegate = self
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
//    private lazy var buttonSave:UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "checkmark.message"), for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.setTitle("Сохранить", for: .normal)
//        button.setTitleColor(UIColor.systemBlue, for: .normal)
//        //button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        return button
//        
//    }()
    
    public var completion: ((String, String) -> Void)?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextfield), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateTextfield), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstrait()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", image: nil, target: self, action: #selector(didTapSave))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    @objc private func updateTextfield(parameter:Notification){
        let userInfo = parameter.userInfo
        let keyBoardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyBoardFrame = self.view.convert(keyBoardRect, to: view.window)
        if parameter.name == UIResponder.keyboardWillHideNotification{
            textField.contentInset = UIEdgeInsets.zero
        } else{
            textField.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardFrame.height, right: 0)
            textField.scrollIndicatorInsets = textField.contentInset
        }
        textField.scrollRangeToVisible(textField.selectedRange)
        
    }
    
    
    
    private func setupConstrait(){
        self.view.addSubview(textField)
        //self.view.addSubview(buttonSave)
        
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            self.textField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -350),
            
//            self.buttonSave.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65),
//            self.buttonSave.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
        
    }
    @objc func didTapSave(){
        if let text = textField.text, text.isEmpty {
            completion?(text, textField.text)
        }
        self.navigationController?.popToRootViewController(animated: true)
//        let push = ViewController()
//        self.navigationController?.pushViewController(push, animated: true)

    }

    }





//
//  AlarmLavelVC.swift
//  iOS-Clock-App
//
//  Created by SHIN YOON AH on 2020/12/06.
//

import UIKit

class AlarmLavelVC: UIViewController {
    @IBOutlet weak var lavelTextField: UITextField!
    
    var saveTextFieldData: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setLavelTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent
        {
            saveTextFieldData?(lavelTextField.text ?? " ")
        }
    }
    
    private func setUpNavigationController() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setLavelTextField() {
        lavelTextField.delegate = self
        lavelTextField.becomeFirstResponder()
    }
}

extension AlarmLavelVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

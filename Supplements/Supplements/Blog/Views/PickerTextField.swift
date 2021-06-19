//
//  PickerTextField.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit

typealias  PickerTextFieldDisplayNumberHandler = ((Any) -> String)
typealias  PickerTextFieldItemSelectionHandler = ((Int, Any) -> Void)
class PickerTextField: UITextField {

    let pickerView = UIPickerView(frame: .zero)
    var lastSelectionRow: Int?
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
     var pills: [Any] = []
     var displayNameHandler: PickerTextFieldDisplayNumberHandler?
     var itemSelectionHandler: PickerTextFieldItemSelectionHandler?
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1.0
        self.layer.borderColor = CGColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.inputView = pickerView
        textColor = .black
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtontapped))
        toolbar.setItems([doneButton], animated: false)
        self.inputAccessoryView = toolbar
        
    }
    @objc func doneButtontapped() {
        self.resignFirstResponder()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    private func updateText() {
        if self.lastSelectionRow == nil {
            self.lastSelectionRow = 0
        }
        if self.lastSelectionRow! > pills.count {
            return
        }
        let data = pills[lastSelectionRow!]
        text = self.displayNameHandler?(data)
    }
}
extension PickerTextField: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = pills[row]
        return self.displayNameHandler?(data)
    }
    
}
extension PickerTextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pills.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lastSelectionRow = row
        updateText()
        let data = pills[row]
        self.itemSelectionHandler?(row, data)
    }
}

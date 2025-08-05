//
//  AmountInputField.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import UIKit

@IBDesignable
final class AmountInputField: UIView {
    var onTyping: (() -> Void)?
    var symbol: Symbol?
    
    public var text: String? {
        return amountTextField.text
    }
    
    @IBInspectable var disabled: Bool = false {
        didSet {
            amountTextField.isEnabled = !disabled
        }
    }
    
    private lazy var amountTextField: PaddingTextField = {
        let field = PaddingTextField()
        field.textAlignment = .left
        field.placeholder = "0.00"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 15)
        field.keyboardType = .decimalPad
        field.returnKeyType = .done
        field.delegate = self
        return field
    }()
    
    lazy var currencyLabel: PaddingLabel = {
        let field = PaddingLabel()
        field.text = "EUR"
        field.textAlignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        field.textColor = .lightGray.withAlphaComponent(0.6)
        field.paddingRight = 8
        return field
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [amountTextField, currencyLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        currencyLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return stack
    }()
    
    
    func set(_ value: String) {
        amountTextField.text = value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.backgroundColor = .lightGray.withAlphaComponent(0.13)
        
        self.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension AmountInputField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        onTyping?()
        
        return true
    }
}

//
//  StringExtention.swift
//  MessengerApp
//
//  Created by Gentjan Manuka on 2024-04-08.
//

import Foundation

extension String {
    func isNotValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: self)
    }
}

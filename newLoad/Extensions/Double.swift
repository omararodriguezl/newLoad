//
//  Double.swift
//  servicesForYourBF
//
//  Created by Omar Rodriguez on 12/8/22.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency () -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}

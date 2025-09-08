import Foundation

extension Double {
    
    /// Преобразует Double в валюту с 2 знаками после запятой
    /// ```
    /// Конвертирует 1234.56 в $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- значение по умолчанию
        //formatter.currencyCode = "usd" // <- изменить валюту
        //formatter.currencySymbol = "$" // <- изменить символ валюты
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Преобразует Double в строку с валютой и 2 знаками после запятой
    /// ```
    /// Конвертирует 1234.56 в "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }

    
    /// Преобразует Double в валюту с 2-6 знаками после запятой
    /// ```
    /// Конвертирует 1234.56 в $1,234.56
    /// Конвертирует 12.3456 в $12.3456
    /// Конвертирует 0.123456 в $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- значение по умолчанию
        //formatter.currencyCode = "usd" // <- изменить валюту
        //formatter.currencySymbol = "$" // <- изменить символ валюты
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Преобразует Double в строку с валютой и 2-6 знаками после запятой
    /// ```
    /// Конвертирует 1234.56 в "$1,234.56"
    /// Конвертирует 12.3456 в "$12.3456"
    /// Конвертирует 0.123456 в "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Преобразует Double в строковое представление
    /// ```
    /// Конвертирует 1.2345 в "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Преобразует Double в строковое представление с символом процента
    /// ```
    /// Конвертирует 1.2345 в "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    
    /// Преобразует Double в строку с сокращениями K, M, Bn, Tr
    /// ```
    /// Конвертирует 12 в 12.00
    /// Конвертирует 1234 в 1.23K
    /// Конвертирует 123456 в 123.45K
    /// Конвертирует 12345678 в 12.34M
    /// Конвертирует 1234567890 в 1.23Bn
    /// Конвертирует 123456789012 в 123.45Bn
    /// Конвертирует 12345678901234 в 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

    
}

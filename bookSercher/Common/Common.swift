//
//  Common.swift
//  bookSearcher
//
//  Created by 백시훈 on 8/6/24.
//

import Foundation
import UIKit
class Common{
    /// 금액에 , 찍어 리턴해주는 함수
    func formatPrice(n: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: n)) ?? "\(n)"
    }
    
}
extension UIViewController {
    /// Alert 호출 함수
    func showAlert(message: String, buttonTitle: String, buttonClickTitle: String) {
        let alert = UIAlertController(title: buttonTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonClickTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    /// 동기처리 Alert함수
    func showSnycAlert(message: String, buttonTitle: String, buttonClickTitle: String, method: @escaping () -> Void) {
        let alert = UIAlertController(title: buttonTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonClickTitle, style: .default, handler: { _ in
            method()
        }))
        present(alert, animated: true, completion: nil)
    }
}

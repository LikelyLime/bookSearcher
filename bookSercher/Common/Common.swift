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

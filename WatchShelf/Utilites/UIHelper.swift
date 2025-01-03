//
//  UIHelper.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 19.09.2024.
//

import UIKit
import ProgressHUD

enum UIHelper {
    static func showHUD() {
        ProgressHUD.animate(symbol: "movieclapper", interaction: false)
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorHUD = .lightText
        ProgressHUD.colorHUD = .clear
    }

    static func dismissHUD() {
        ProgressHUD.dismiss()
    }
    
    static func showHUDerror(_ message: String = "Something went wrong") {
        ProgressHUD.failed(message)
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorHUD = .lightText
    }
}

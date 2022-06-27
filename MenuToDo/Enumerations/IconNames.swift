//
//  IconNames.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import SwiftUI

enum IconNames {
    case listBulletFill

    var systemSymbolName: String {
        switch self {
        case .listBulletFill:
            return "list.bullet.rectangle.portrait.fill"
        }
    }

    var accessibilityDescription: String {
        switch self {
        case .listBulletFill:
            return "Task List"
        }
    }

    var nsImage: NSImage? {
        switch self {
        case .listBulletFill:
            return NSImage(systemSymbolName: systemSymbolName, accessibilityDescription: accessibilityDescription)
        }
    }
}

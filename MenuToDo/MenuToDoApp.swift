//
//  MenuToDoApp.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import SwiftUI

@main
struct MenuToDoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings { }
    }
}

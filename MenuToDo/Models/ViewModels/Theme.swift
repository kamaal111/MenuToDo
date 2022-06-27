//
//  Theme.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import Foundation

final class Theme: ObservableObject {
    
    @Published private(set) var menubarIcon: IconNames
    
    init() {
        self.menubarIcon = .listBulletFill
    }

}

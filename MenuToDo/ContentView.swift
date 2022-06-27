//
//  ContentView.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ToDoExperience()
            .frame(width: Constants.UI.popoverSize.width, height: Constants.UI.popoverSize.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

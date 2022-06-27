//
//  ToDoExperience.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import SwiftUI
import SalmonUI

struct ToDoExperience: View {
    @State private var text = ""

    var body: some View {
        VStack {
            Text("ToDo's")
                .font(.title)
                .bold()
                .ktakeWidthEagerly(alignment: .leading)
            Spacer()
            KFloatingTextField(text: $text, title: "Item")
        }
        .padding(.horizontal, .small)
        .padding(.vertical, .medium)
        .ktakeSizeEagerly(alignment: .top)
    }
}

struct ToDoExperience_Previews: PreviewProvider {
    static var previews: some View {
        ToDoExperience()
    }
}

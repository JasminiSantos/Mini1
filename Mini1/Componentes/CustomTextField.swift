//
//  CustomTextField.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/06/23.
//

import SwiftUI

struct CustomTextField: View {
    @State var taskDescription: String = "Teste"
    
    var body: some View {
        TextField("", text: $taskDescription)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .foregroundColor(Color(.systemGray2))
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField()
    }
}

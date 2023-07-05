//
//  CustomTextField.swift
//  Mini1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 30/06/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var taskDescription: String
    @State private var typedMessage: String
    @Binding var allowSaving: Bool
    
    init(taskDescription: Binding<String>, allowSaving: Binding<Bool>) {
        _taskDescription = taskDescription
        _typedMessage = State(initialValue: taskDescription.wrappedValue)
        _allowSaving = allowSaving
    }
    
    var body: some View {
        TextField("", text: Binding(
            get: { self.typedMessage },
            set: { newValue in
                self.typedMessage = newValue
                if allowSaving {
                    self.taskDescription = self.typedMessage
                    allowSaving = false
                }
            }
        ))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
        .foregroundColor(Color("Placeholder_Texto"))
        .background(Color("Background"))
        .cornerRadius(10)
        
    }
}


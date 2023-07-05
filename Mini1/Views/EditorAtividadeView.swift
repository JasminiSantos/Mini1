//
//  EditorAtividadeView.swift
//  Mini1
//
//  Created by Robson Borges on 26/06/23.
//

import SwiftUI

struct EditorAtividadeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTimeADay = Date()
    @State private var selectedNotifications = Date()
    @State var allowSaving = false
    @Binding var atividade : Atividade
    
    var body: some View {
        
        ScrollView {
            header
            content
        }
        .background(Color("Cards"))
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text("Nome")
                .font(.callout)
                .bold()
                .font(.system(size: 16))
                .foregroundColor(Color("Texto"))
            
            if atividade.getChatEditou() {
                CustomTextField(taskDescription: $atividade.modAcao, allowSaving: $allowSaving)
            }
            else {
                CustomTextField(taskDescription: $atividade.acao, allowSaving: $allowSaving)
            }
            
            Rectangle()
                .frame(height: 1)
                .opacity(0.33)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            VStack(spacing: 20) {
                Scheduler(icon: "clock.fill", color: Color("Azul"), title: "Tempo por dia")
                
                CustomScheduler()
                
                CustomToggle2(isToggleOn: $atividade.modificavel, icon: "wand.and.stars", color: Color("Roxo"), title: "Adaptável")
                    .padding(.horizontal)
                    .background(Color("Background"))
                    .cornerRadius(8)
                
//                Scheduler(icon: "megaphone.fill", color: Color("Roxo"), title: "Notificações")
            }
        }
        .padding()
    }
    
    var header: some View {
        HStack(alignment: .top) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancelar")
                    .font(.body)
                    .font(.system(size: 17))
                    .foregroundColor(Color("Verde"))
            }
            
            Spacer()
            
            Text("Editar atividade")
                .font(.headline)
                .font(.system(size: 17))
                .foregroundColor(Color("Texto"))
            
            Spacer()
            
            Button(action: {
                saveAtividade()
            }) {
                Text("Salvar")
                    .font(.body)
                    .font(.system(size: 17))
                    .foregroundColor(Color("Verde"))
            }
        }
        .padding(.horizontal)
        .padding(.top, 30)
        .padding(.bottom, 20)
    }
    
    func saveAtividade() {
        allowSaving = true
        presentationMode.wrappedValue.dismiss()
    }
}

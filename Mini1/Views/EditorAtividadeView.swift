//
//  EditorAtividadeView.swift
//  Mini1
//
//  Created by Robson Borges on 26/06/23.
//

import SwiftUI

struct EditorAtividadeView: View {
    @State private var selectedTimeADay = Date()
    @State private var selectedNotifications = Date()
    
    var body: some View {
        
        ScrollView {
            header
            content
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text("Nome")
                .font(.callout)
                .bold()
                .font(.system(size: 16))
                .foregroundColor(.black)
                
            CustomTextField()
            
            Rectangle()
                .frame(height: 1)
                .opacity(0.33)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            VStack(spacing: 20) {
                Scheduler(icon: "clock.fill", color: .purple, title: "Tempo por dia", subtitle: "8:00 horas")
                
                CustomScheduler()
                
                CustomToggle2(icon: "wand.and.stars", color: .teal, title: "Adaptável")
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Scheduler(icon: "megaphone.fill", color: .green, title: "Notificações", subtitle: "8:00 horas")
            }
        }
        .padding()
    }
    
    var header: some View {
        HStack(alignment: .top, spacing: 40) {
            Text("Cancelar")
                .font(.body)
                .font(.system(size: 17))
                .foregroundColor(.blue)
            
            Text("Editar atividade")
                .font(.headline)
                .font(.system(size: 17))
                .foregroundColor(.black)
            
            Text("Salvar")
                .font(.body)
                .font(.system(size: 17))
                .foregroundColor(.blue)
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
    }
}

struct EditorAtividadeView_Previews: PreviewProvider {
    static var previews: some View {
        EditorAtividadeView()
    }
}

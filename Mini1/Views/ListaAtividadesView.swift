//
//  ListaAtividadesView.swift
//  Mini1
//
//  Created by Robson Borges on 26/06/23.
//

import SwiftUI

struct ListaAtividadesView: View {
    let mood : MoodCard
    @StateObject var lista = ListaAtividades()
    var body: some View {
        ScrollView{
            HStack{
                Text(mood.emoji)
                    .font(.system(size: 40))
                    
                
                Text("Suas atividades")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            VStack(spacing: 20){
                ForEach(lista.lista.indices) { index in
                    AtividadeView(atividade: $lista.lista[index])
                        .frame(maxHeight: 100)
                        .cornerRadius(16)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct ListaAtividadesView_Previews: PreviewProvider {
    static var previews: some View {
        ListaAtividadesView(mood: MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!"))
    }
}

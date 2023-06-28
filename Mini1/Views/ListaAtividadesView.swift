//
//  ListaAtividadesView.swift
//  Mini1
//
//  Created by Robson Borges on 26/06/23.
//

import SwiftUI




struct ListaAtividadesView: View {
    @ObservedObject var lista : ListaAtividades
    @Binding var mood : MoodCard
    
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
            VStack{
                Text("Concluidas")
                ForEach(lista.lista.indices) { index in
                    if(lista.lista[index].getConcluida()){
                        AtividadeView(atividade: $lista.lista[index])
                            .frame(maxHeight: 120)
                            .cornerRadius(16)
                    }
                }
            }
            VStack{
                Text("Não concluidas")
                ForEach(lista.lista.indices) { index in
                    if(lista.lista[index].getConcluida() == false){
                        AtividadeView(atividade: $lista.lista[index])
                            .frame(maxHeight: 120)
                            .cornerRadius(16)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct ListaAtividadesView_Previews: PreviewProvider {
    @State static private var moodSelected = MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!")
    @StateObject static private var lista = ListaAtividades()
    static var previews: some View {
        ListaAtividadesView(lista: lista, mood: $moodSelected)
    }
}

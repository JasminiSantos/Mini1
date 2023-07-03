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
    @State var voltarView : Bool = false
    @State var carregando : Bool = true
    @State var editMod : Bool = false
    
    var body: some View {
            ScrollView {
                HStack {
                    Button(action:{
                        voltarView = true
                    }){
                        Text(mood.emoji)
                            .font(.system(size: 40))
                    }
                    .fullScreenCover(isPresented: $voltarView){
                        OnboardingView()
                    }
                    
                    Text("Suas atividades")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if(!carregando && !editMod){
                    
                    VStack {
                        ForEach(lista.lista.indices) { index in
                            if !lista.lista[index].concluida {
                                AtividadeView(atividade: $lista.lista[index],lista: lista,indice: index,editMod: false)
                                    .cornerRadius(16)
                            }
                        }
                        ForEach(lista.lista.indices) { index in
                            if lista.lista[index].concluida {
                                AtividadeView(atividade: $lista.lista[index],lista: lista,indice: index,editMod:false)
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
                else if(editMod){
                    VStack {
                        ForEach(Array(lista.lista.enumerated()), id: \.element.id) { (index, atividade) in
                            if !atividade.concluida {
                                AtividadeView(atividade: $lista.lista[index], lista: lista, indice: index, editMod: true)
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
                else{
                    VStack{
                        Text("Modificando suas atividades...")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .onAppear {
                
                Task {
                    for atividade in lista.lista {
                        await ModificadorAtividade().modificar(atividade: atividade, mood: mood)
                    }
                    carregando = false
                }
                
                
            }
    }
}

struct ListaAtividadesView_Previews: PreviewProvider {
    @State static private var moodSelected = MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!")
    @StateObject static private var lista = ListaAtividades()
    static var previews: some View {
        ListaAtividadesView(lista: lista, mood: $moodSelected)
    }
}

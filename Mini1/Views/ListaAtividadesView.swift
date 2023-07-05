//
//  ListaAtividadesView.swift
//  Mini1
//
//  Created by Robson Borges on 26/06/23.
//

import SwiftUI




struct ListaAtividadesView: View {
    @Binding var mood : MoodCard
    @State var voltarView : Bool = false
    @State var carregando : Bool = true
    @State var editMod : Bool = false
    
    @StateObject var listaAtividades = ListaAtividades()
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(maxHeight: 100)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .ignoresSafeArea()
                HStack {
                    Button(action:{
                        editMod.toggle()
                    }){
                        if(editMod){
                            Image(systemName: "checkmark")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color("Verde"))
                        }
                        else{
                            Text("Editar")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color("Verde"))
                        }
                    }
                    Text("Emotivate")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button(action:{
                        
                    }){
                        Image(systemName: "plus")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(Color("Verde"))
                    }
                }
                .padding(.horizontal,32)
                .padding(.top,48)
            }
            HStack {
                Button(action:{
                    voltarView = true
                }){
                    HStack{
                        ZStack(alignment: .center){
                            Circle()
                                .foregroundColor(Color("Verde"))
                                .frame(maxWidth: 50,alignment: .center)
                            Text(mood.emoji)
                                .font(.system(size: 35))
                                .frame(alignment: .center)
                        }
                        Text("Suas atividades")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("Texto"))
                        
                    }
                }
                .fullScreenCover(isPresented: $voltarView){
                    OnboardingView()
                }
                
            }
            .padding(32)
            VStack{
                ScrollView {
                    
                    VStack{
                        if(!carregando && !editMod){
                            
                            VStack {
                                ForEach(listaAtividades.lista) { atividade in
                                    if !atividade.concluida {
                                        AtividadeView(atividade: atividade, editMod: false)
                                            .cornerRadius(16)
                                            .shadow(radius: 5)
                                            .padding(.horizontal,32)
                                            .padding(.vertical,8)
                                    }
                                }
                                
                                ForEach(listaAtividades.lista) { atividade in
                                    if atividade.concluida {
                                        AtividadeView(atividade: atividade, editMod: false)
                                            .cornerRadius(16)
                                            .shadow(radius: 5)
                                            .padding(.horizontal,32)
                                            .padding(.vertical,8)
                                    }
                                }
                            }
                        }
                        else if(editMod){
                            VStack {
                                ForEach(listaAtividades.lista) { atividade in
                                    if !atividade.concluida {
                                        AtividadeView(atividade: atividade, editMod: true)
                                            .cornerRadius(16)
                                            .shadow(radius: 5)
                                            .padding(.horizontal,32)
                                            .padding(.vertical,8)
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
                    Spacer()
                }
                .background(Color("Background"))
                .onAppear {
                    //Carrega os cards salvos ou um de exemplo caso não encontre
                    listaAtividades.inicializar()
                    //Thred para modificar os cards com o chat
                    Task {
                        for atividade in listaAtividades.lista {
                            //await ModificadorAtividade().modificar(atividade: atividade, mood: mood)
                        }
                        carregando = false
                    }
                    
                    
                }
            }
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        .environmentObject(listaAtividades)
    }
}

struct ListaAtividadesView_Previews: PreviewProvider {
    @State static private var moodSelected = MoodCard(emoji: "😆", title: "Super", description: "Aumente minhas metas!")
    @StateObject static private var lista = ListaAtividades()
    static var previews: some View {
        ListaAtividadesView(mood: $moodSelected)
    }
}

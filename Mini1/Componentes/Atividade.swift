//
//  Atividade.swift
//  testChat
//
//  Created by Robson Borges on 23/06/23.
//
import SwiftUI
import Foundation

class Atividade: Identifiable{
    let ID  = UUID()
    var concluida : Bool = false
    var textoOriginal : String
    var textoModificado : String
    var dataCriacao : Date
    var dataConclusao : Date? = nil
    
    init(textoOriginal:String,textoModificado:String){
        self.textoOriginal = textoOriginal
        self.textoModificado = textoModificado
        self.dataCriacao = Date()
    }
    func concluir(){
        self.concluida = true
        self.dataConclusao = Date()
    }
    func setTextoOriginal(texto:String){
        self.textoOriginal = texto
    }
    func setTextoModificado(texto:String){
        self.textoModificado = texto
    }
    func getTextoOriginal() -> String {
        return self.textoOriginal
    }
    func getTextoModificado() -> String {
        return self.textoModificado
    }
    func getConcluida() -> Bool{
        return self.concluida
    }
    func getDataConcluida() -> Date? {
        if self.concluida{
            return self.dataConclusao
        }
        print("Atividade não concluida, Data de conclusão não existe.")
        return nil
    }
}


class ListaAtividades : Identifiable, ObservableObject{
    var lista = [Atividade(textoOriginal: "Ler 30 páginas de um livro", textoModificado: ""),
                           Atividade(textoOriginal: "Caminhar por 50 minutos", textoModificado: ""),
                           Atividade(textoOriginal: "Beber 8 copos de água por dia", textoModificado: ""),
                           Atividade(textoOriginal: "Consumir 5 porções de frutas e vegetais diariamente", textoModificado: ""),
                           Atividade(textoOriginal: "Dormir 7-8 horas por noite", textoModificado: ""),
                           Atividade(textoOriginal: "Praticar 15 minutos de meditação diariamente", textoModificado: "")]
    
}

struct AtividadeView: View{
    @Binding var atividade : Atividade
    @State var edit : Bool = false
    var body: some View{
        NavigationView{
            HStack{
                Text(atividade.textoOriginal)
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .foregroundColor(.black)
                    .padding()
                
                NavigationLink(destination: EditorAtividadeView()){
                    Button(action: {
                        
                    }){
                        Image(systemName: "pencil")
                            .font(.system(size: 24))
                    }
                }
                
                Button(action:{
                    edit = true
                    atividade.concluir()
                }){
                    Image(systemName: atividade.concluida == true ? "checkmark.square.fill": "square")
                        .font(.system(size: 24))
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
            .cornerRadius(16)
        }
        
    }
}

struct AtividadeView_Previews: PreviewProvider{
    
    static var previews: some View{
        let atv = Atividade(textoOriginal: "Ler 30 páginas de um livro", textoModificado: "")
        return AtividadeView(atividade: .constant(atv))
    }
}

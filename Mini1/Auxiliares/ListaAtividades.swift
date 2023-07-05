//
//  ListaAtividades.swift
//  Mini1
//
//  Created by Robson Borges on 04/07/23.
//


// Responsável por gerenciar toda a lista de tarefas
// realiza também o gerenciamento dos arquivos atravez de GerenciadorArquivos
import SwiftUI
import Foundation



class ListaAtividades: ObservableObject {
    //Essa deve ser a única lista criada e gerenciada pelo sistema
    
    @Published var indices : Range<Int> = 0..<0
    //static let concluidas = ListaAtividades()
    @Published var lista = [Atividade]()

    public init() {}
    
    func inicializar(){
        if(!self.recuperar()) {
            self.lista.append(Atividade(acao: "Este daqui é um card para seu hábito."))
            self.indices = self.lista.indices
        }
    }
    func atualizarAtividade(atividade: Atividade){
        let indice = self.lista.firstIndex(of: atividade)!
        lista[indice] = atividade
        
    }
    //Adiciona uma atividade a lista
    func adicionar(novaAtividade: Atividade) {
        self.lista.append(novaAtividade)
        GerenciadorArquivos.addAtividade(novaAtividade)
        self.indices = self.lista.indices
        print("Tamanho: \(self.lista.count)")
    }
    //remove um elemento da lista
    func remover(atividade: Atividade) -> Bool {
        print(self.lista.indices)
        
        let tam = self.lista.count
        self.lista.removeAll { $0.ID == atividade.ID }
        self.indices = self.lista.indices
        
        
        print(self.lista.indices)
        return tam > self.lista.count
    }
    //recarrega todos os arquivos salvos
    func recuperar() -> Bool {
        let recLista = GerenciadorArquivos.getAtividades()
        self.lista = recLista  // Substitui toda a lista existente pelos itens recuperados
        self.indices = self.lista.indices
        return !self.lista.isEmpty
    }
    func indexValido(index: Int) -> Bool{
        return self.lista.count > index
    }
    
    //Sobrecarga de operador [], é possível fazer ListaAtividades[index]
    subscript(index: Int) -> Binding<Atividade> {
        Binding(
            get: {
                self.lista[index]
            },
            set: { newValue in
                self.lista[index] = newValue
            }
        )
    }
}

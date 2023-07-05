//
//  Modificador.swift
//  Mini1
//
//  Created by Robson Borges on 27/06/23.
//
import SwiftUI
import Foundation


struct ModificadorAtividade {
    @ObservedObject var apiRequestManager = ChatRequestManager()
    
    private func promptMakerAction(acao: String, duracao: String) -> String{
        //Aqui vamos compor o prompt para o chat.
        return "Terminar..."
    }
    private func promptMakerDuration(mood: MoodCard,active: Atividade) -> String{
        var prom = ""
        if(mood.title == "Ambicioso"){
            prom = "Você dificulta tarefas, quando for possível deixe as tarefas mais difíceis e caso não seja possível retorne o mesmo texto da tarefa. Sua resposta deve ser uma única linha com a tarefa original ou a tarefa mais difícil. \nExemplo 01: entrada 'Correr por 50 minuto' , saída 'Correr por 1 hora e 20 minutos'. \n Exemplo 02: entrada 'Ir a padaria comprar pão' , saída 'Ir a padaria comprar pão'. \n Exemplo 03: entrada 'Dormir 8 horas' saída 'Dormir 8 horas'. \nAgora dificulte esta tarefa: '" + active.getAcao() + "'."
        }
        else if(mood.title == "Determinado"){
            prom = "Você dificulta tarefas levemente, quando for possível deixe as tarefas mais difíceis e caso não seja possível retorne o mesmo texto da tarefa. Sua resposta deve ser uma única linha com a tarefa original ou a tarefa mais difícil. \nExemplo 01: entrada 'Correr por 50 minuto' , saída 'Correr por 60 minutos'. \n Exemplo 02: entrada 'Ir a padaria comprar pão' , saída 'Ir a padaria comprar pão'.\n Exemplo 03: entrada 'Dormir 8 horas' saída 'Dormir 8 horas'. \nAgora dificulte esta tarefa: '" + active.getAcao() + "'."
        }
        else if (mood.title == "Cansado"){
            prom = "Você é um leve facilitador de tarefas, quando for possível, facilite-as e caso não seja retorne o mesmo texto da tarefa. Sua resposta deve ser uma única linha com a tarefa original ou a tarefa facilitada. \nExemplo 01: entrada 'Correr por 50 minuto' , saída 'Correr por 35 minutos'. \n Exemplo 02: entrada 'Ir a padaria comprar pão' , saída 'Ir a padaria comprar pão'.\n Exemplo 03: entrada 'Dormir 7 horas' saída 'Dormir 8 horas'. \n Exemplo 04: entrada 'Brincar com o cachorro por 10 minutos' saída 'Brincar com o cachorro por 15 minutos'. \nAgora facilite esta tarefa: '" + active.getAcao() + "'."
        }
        else if (mood.title == "Desmotivado"){
            prom = "Você é um facilitador de tarefas, quando for possível, facilite-as e caso não seja retorne o mesmo texto da tarefa. Sua resposta deve ser uma única linha com a tarefa original ou a tarefa facilitada. \nExemplo 01: entrada 'Correr por 50 minuto' , saída 'Correr por 20 minutos'. \n Exemplo 02: entrada 'Ir a padaria comprar pão'. , saída 'Ir a padaria comprar pão'. \n Exemplo 03: entrada 'Dormir 8 horas' saída 'Dormir 9 horas'. \n Exemplo 04: entrada 'Brincar com o cachorro por 10 minutos' saída 'Brincar com o cachorro por 15 minutos'. \n Agora facilite esta tarefa: '" + active.getAcao() + "'."
        }
        return prom
    }
    //chamar a função apenas se precisar modificar
    func modificar(atividade: Atividade,mood: MoodCard) async {
        if(!atividade.concluida){
            let duracao = self.promptMakerDuration(mood: mood, active: atividade)
            if !duracao.isEmpty {
                let data = await self.apiRequestManager.makeRequest(text: duracao)
                if let data = apiRequestManager.responseData {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let choices = json["choices"] as? [[String: Any]] {
                            if let text = choices[0]["text"] as? String {
                                atividade.setModificar(acao: text)
                            }
                        }
                    }
                }
                
            }
        }
    }
}

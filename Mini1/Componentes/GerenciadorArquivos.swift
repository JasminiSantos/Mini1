
import Foundation

//Struct para realizar o salvamento dos arquivos corretamente
//Ela deve ser alterada de acordo com a classe Atividade
struct StructAtividade: Codable {
    let ID : UUID
    let concluida: Bool
    let mostrarModChat: Bool
    let chatEditou: Bool
    let acao: String
    let modAcao: String
    let dataCriacao: Date
    let dataConclusao: Date
    
    init(ID: UUID,concluida: Bool,mostrarModChat: Bool,chatEditou: Bool, acao: String, modAcao:String,dataCriacao:Date,dataConclusao:Date){
        self.ID = ID
        self.concluida = concluida
        self.mostrarModChat = mostrarModChat
        self.chatEditou = chatEditou
        self.acao = acao
        self.modAcao = modAcao
        self.dataCriacao = dataCriacao
        self.dataConclusao = dataConclusao
    }
}



class GerenciadorArquivos{
    // Caminho para o arquivo onde os dados serão armazenados
    static let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("atividades.json")
    
    
    
    // Função para obter a lista de atividades do arquivo
    static func getAtividades() -> [Atividade] {
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let atividades = try decoder.decode([StructAtividade].self, from: data)
            var lista = [Atividade]()
            for act in atividades{
                lista.append(Atividade.createAtividade(atividade: act))
            }
            return lista
        } catch {
            print("Erro ao obter os dados: \(error)")
            return []
        }
    }
    
    // Função para adicionar uma atividade à lista
    static func addAtividade(_ atividade: Atividade) {
        var atividades = getAtividades()
        atividades.append(atividade)
        saveAtividades(atividades)
    }
    
    // Função para remover uma atividade da lista
    static func removeAtividade(_ atividadeID: UUID) {
        var atividades = getAtividades()
        if let index = atividades.firstIndex(where: { $0.ID == atividadeID }) {
            atividades.remove(at: index)
            saveAtividades(atividades)
        }
    }
    
    // Função para salvar a lista de atividades no arquivo
    static func saveAtividades(_ atividades: [Atividade]) {
        do {
            var lista = [StructAtividade]()
            for at in atividades{
                lista.append(Atividade.createStructAtividade(atividade: at))
            }
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(lista)
            try data.write(to: filePath)
        } catch {
            print("Erro ao salvar os dados: \(error)")
        }
    }
}

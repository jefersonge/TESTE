//
//  ViewController.swift
//  LOTERIA
//
//  Created by Jeferson Dias dos Santos on 26/07/22.
//

import UIKit
//PRIMEIRO 1 - CRIAMOS ENUM PARA CONTER DOIS CENARIOS - MEGA E QUINA
enum GameType: String{ //PRIMEIRO 2 - rawValue neste caso do tipo String
    case megasena = "Mega-Sena" //PRIMEIRO 3 - Neste caso "Mega-Sena" e "Quina" sao os valores brutos(rawVaue) associado a cada case, esses nomes tambem serao usados para mudar a LABEL do aplicativo o texto na parte de cima contendo o nome do jogo a ser gerado
    case quina = "Quina"
}
//SEGUNDO 1 - CRIAR A MANEIRA DE GERAR OS NUMEROS/JOGOS USANDO UM OPERADOR PERSONALIZADO INFIX
infix operator >-<
    func >-< (total: Int, universe: Int) -> [Int] { //SEGUNDO 2 - criamos operador >-< onde total é qtde de numeros a ser gerados e universe sao os numeros a ser usado exemplo mega sena 60 devolvendo um array de int -> [Int]
        var result: [Int] = []
        while result.count < total {
            let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
            if !result.contains(randomNumber){
                result.append(randomNumber)
            }
            }
        
        return result.sorted()
    }

class ViewController: UIViewController {
    @IBOutlet var balls: [UIButton]! //ao criar um outlet colection ele vem como array de botao[UIButton] ou seja uma colecao de botoes entao posso clocar e arrastar para as outras bolas
    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    
    
    
    
    override func viewDidLoad() {//Funcao chamada sempre que a tela do app carrega
        super.viewDidLoad()// Do any additional setup after loading the view.  //Momento ideal para comecar mostrar jogo
        showNumbers(for: .megasena) //TERCEIRA 2 - Chamando assim a funcao diz que - ao abrir o app mostre os numeros para mega sena
    }
    
    func showNumbers (for type: GameType) {//TERCEIRA 1 - Funcao que vai mostrar os jogos na tela - mostra os numeros para (for) gameType - o ENUM criado
        lbGameType.text = type.rawValue // TERCEIRA 3 - Esse metodo/func vai fazer o que... vai pegar a LABEL/ROTULO E vai trocar a propriedade.text - esse texto vai ser o type(tipo de joogo) e extrar o rawValue("Mega-Sena" e "Quina") de acordo com o tipo(case) criado em ENUM
        var game: [Int] = []//QUARTO 1 - Criamos um array chamado game do tipo Int que vai conter os numeros sorteados
        switch type { //QUARTO 2 - Criamos um switch com o enum criado para que caso o type seja mega sena o game tera 6 dezenas de 60 e caaso seja quina tera 5 dezenas de 80.
            case .megasena:
                game = 6>-<60
            balls.last!.isHidden = false  //QUARTO 3 - esse codigo diz que a ultima bola das 6 nao esta escondida
            case .quina:
                game = 5>-<80
            balls.last!.isHidden = true //QUARTO 4 - neste caso como a quina sao apenas 5 numeros esse codigo diz que a ultima bola das 6 esta oculta
        }
        for (index, game) in game.enumerated(){//QUINTO 1 - criamos o esse codigo para fazer com que os numeros gerados aparecam nas bolinhas do app  - usamos enumerated para pegar o indice e o valor do array dentro do for que devolveu uma tupla de chave e valor (key e value) que chamamos de (index, game)
            balls[index].setTitle("\(game)", for: .normal) //QUINTO 2 - No meu array de balls vou pegar a bola que se encontra nesse indice[index] e vou deifinir o titulo dela(o numero)atraves do.setTitle e vamos colocar o game como titulo "\(game)" dessa maneira cada uma dessas bolas vao entrar como titulo
        }
    }
    
//ULTIMO - CRIANDO METODO PARA BOTAO GERAR NOVO NUMEROS E BOTAO QUINA E MEGA
    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex { //ULT 1 - Criado o switch no segmento de control (Botao mega e quina) dizendo que caso indice do segmento seelecionado (mega ow quina)primero = 0
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
        
    }
    
}


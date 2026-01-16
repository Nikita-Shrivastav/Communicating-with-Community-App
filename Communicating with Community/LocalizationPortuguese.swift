import Foundation

struct PortugueseLocalizationProvider: LocalizationProvider {
    let displayName = "Português"
    let languageCode = "pt"
    let preferredVoiceCodes: [String] = ["pt-PT", "pt-BR", "pt"]

    func categoryTitle(for category: ItemCategory) -> String {
        switch category {
        case .need:
            return "Necessidades"
        case .want:
            return "Desejos"
        case .feeling:
            return "Sentimentos"
        }
    }

    var wordBank: [String] {
        portugueseWordBank
    }

    var items: [NeedItem] {
        portugueseItems
    }
}

let portugueseWordBank: [String] = [
    // Core pronouns / helpers
    "eu", "você", "nós", "eles", "ele", "ela",
    "quero", "preciso", "sinto", "sou", "é", "são",
    "a", "ir", "brincar", "comer", "beber", "ver", "achar", "ajudar", "ajuda",
    "por favor", "agora", "depois", "mais", "menos", "parar",

    // People
    "mamãe", "papai", "irmão", "irmã",
    "professor", "amigo", "amiga", "médico", "enfermeira",
    "avó", "avô", "bebê", "família",

    // Feelings
    "feliz", "triste", "zangado", "cansado", "assustado",
    "machucado", "animado", "nervoso", "preocupado", "calmo",

    // Food & drinks
    "água", "comida", "suco", "leite", "sorvete", "pizza", "sanduíche",
    "arroz", "massa", "macarrão", "maçã", "banana", "biscoito",
    "pão", "batata frita", "sopa", "cereal", "ovo",

    // Places
    "casa", "escola", "fora", "dentro", "banheiro",
    "cozinha", "parque", "carro", "cama", "mesa",

    // Body parts
    "cabeça", "braço", "perna", "mão", "pé",
    "estômago", "costas", "olho", "orelha", "boca",

    // Injuries / sensations
    "dor", "coceira", "quente", "frio",
    "sangramento", "corte", "roxo", "doente", "tonto",
    "cãibra", "torção",

    // Actions
    "sentar", "levantar", "andar", "correr",
    "pular", "dormir", "descansar",
    "abrir", "fechar", "olhar", "tocar",
    "ouvir", "esperar", "lavar", "limpar",

    // Extras
    "sim", "não", "talvez",
    "isso", "aquilo", "lá", "aqui",
    "meu", "seu",

    // Describing words
    "grande", "pequeno", "forte", "suave",
    "rápido", "lento", "bom", "mau",
    "frio", "quente", "morno"
]

let portugueseItems: [NeedItem] = [
    // Needs (10 items)
    NeedItem(image: "water", text: "Preciso de água", category: .need),
    NeedItem(image: "food", text: "Preciso de comida", category: .need),
    NeedItem(image: "bed", text: "Preciso dormir", category: .need),
    NeedItem(image: "toilet", text: "Preciso ir ao banheiro", category: .need),
    NeedItem(image: "help", text: "Preciso de ajuda", category: .need),
    NeedItem(image: "medicine", text: "Preciso de remédio", category: .need),
    NeedItem(image: "break", text: "Preciso de uma pausa", category: .need),
    NeedItem(image: "quiet", text: "Preciso de silêncio", category: .need),
    NeedItem(image: "hug", text: "Preciso de um abraço", category: .need),
    NeedItem(image: "space", text: "Preciso de espaço", category: .need),

    // Wants (10 items)
    NeedItem(image: "walk", text: "Quero passear", category: .want),
    NeedItem(image: "play", text: "Quero brincar", category: .want),
    NeedItem(image: "mom", text: "Quero a mamãe", category: .want),
    NeedItem(image: "dad", text: "Quero o papai", category: .want),
    NeedItem(image: "brother", text: "Quero meu irmão", category: .want),
    NeedItem(image: "sister", text: "Quero minha irmã", category: .want),
    NeedItem(image: "friend", text: "Quero ver meu/minha amigo/a", category: .want),
    NeedItem(image: "outside", text: "Quero ir lá fora", category: .want),
    NeedItem(image: "watch", text: "Quero assistir a algo", category: .want),
    NeedItem(image: "music", text: "Quero ouvir música", category: .want),

    // Feelings (10 items)
    NeedItem(image: "mad", text: "Eu me sinto com raiva", category: .feeling),
    NeedItem(image: "sad", text: "Eu me sinto triste", category: .feeling),
    NeedItem(image: "happy", text: "Eu me sinto feliz", category: .feeling),
    NeedItem(image: "anxious", text: "Eu me sinto ansioso/ansiosa", category: .feeling),
    NeedItem(image: "scared", text: "Eu me sinto com medo", category: .feeling),
    NeedItem(image: "jealous", text: "Eu me sinto com ciúmes", category: .feeling),
    NeedItem(image: "tired", text: "Eu me sinto cansado/cansada", category: .feeling),
    NeedItem(image: "excited", text: "Eu me sinto animado/animada", category: .feeling),
    NeedItem(image: "confused", text: "Eu me sinto confuso/confusa", category: .feeling),
    NeedItem(image: "sick", text: "Eu me sinto doente", category: .feeling)
]

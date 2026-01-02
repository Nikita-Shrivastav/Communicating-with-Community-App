import Foundation

/// Spanish localization provider for the communication board
struct SpanishLocalizationProvider: LocalizationProvider {
    let displayName = "Español"
    let languageCode = "es"
    let preferredVoiceCodes = ["es-ES", "es-MX", "es-US", "es"]
    
    func categoryTitle(for category: NeedItem.Category) -> String {
        switch category {
        case .need: return "Necesidades"
        case .want: return "Deseos"
        case .feeling: return "Sentimientos"
        }
    }
    
    var wordBank: [String] {
        spanishWordBank
    }
    
    var items: [NeedItem] {
        spanishItems
    }
}

// Spanish word bank for sentence builder
let spanishWordBank: [String] = [
    // Core pronouns / helpers
    "yo", "tú", "nosotros", "ellos", "él", "ella",
    "quiero", "necesito", "siento", "soy", "es", "son",
    "a", "ir", "jugar", "comer", "beber", "ver", "encontrar", "ayudar",
    "por favor", "ahora", "después", "más", "menos", "parar",
    
    // People
    "mamá", "papá", "hermano", "hermana",
    "maestro", "amigo", "doctor", "enfermera",
    "abuela", "abuelo", "bebé", "familia",
    
    // Feelings
    "feliz", "triste", "enojado", "cansado", "asustado",
    "herido", "emocionado", "nervioso", "preocupado", "tranquilo",
    
    // Food & drinks
    "agua", "jugo", "leche", "helado", "pizza", "sándwich",
    "arroz", "pasta", "fideos", "manzana", "plátano", "galleta",
    "pan", "papas fritas", "sopa", "cereal", "huevo",
    
    // Places
    "casa", "escuela", "afuera", "adentro", "baño",
    "cocina", "parque", "carro", "cama", "mesa",
    
    // Body parts
    "cabeza", "brazo", "pierna", "mano", "pie",
    "estómago", "espalda", "ojo", "oreja", "boca",
    
    // Injuries / sensations
    "dolor", "picazón", "caliente", "frío",
    "sangrado", "corte", "moretón", "enfermo", "mareado",
    "calambre", "torcedura",
    
    // Actions
    "sentar", "parar", "caminar", "correr",
    "saltar", "dormir", "descansar",
    "abrir", "cerrar", "mirar", "tocar",
    "escuchar", "esperar", "lavar", "limpiar",
    
    // Extras
    "sí", "no", "tal vez",
    "esto", "eso", "allí", "aquí",
    "mío", "tuyo",
    
    // Describing words
    "grande", "pequeño", "fuerte", "suave",
    "rápido", "lento", "bueno", "malo",
    "frío", "caliente", "tibio"
]

// Spanish localized items for categories
let spanishItems: [NeedItem] = [
    // Needs
    NeedItem(image: "water", text: "Quiero agua", category: .need),
    NeedItem(image: "food", text: "Quiero comida", category: .need),
    NeedItem(image: "bed", text: "Quiero dormir", category: .need),
    NeedItem(image: "toilet", text: "Quiero ir al baño", category: .need),
    
    // Wants
    NeedItem(image: "walk", text: "Quiero caminar", category: .want),
    NeedItem(image: "play", text: "Quiero jugar", category: .want),
    NeedItem(image: "mom", text: "Quiero a mamá", category: .want),
    NeedItem(image: "dad", text: "Quiero a papá", category: .want),
    NeedItem(image: "brother", text: "Quiero a mi hermano", category: .want),
    NeedItem(image: "sister", text: "Quiero a mi hermana", category: .want),
    
    // Feelings
    NeedItem(image: "mad", text: "Me siento enojado/a", category: .feeling),
    NeedItem(image: "sad", text: "Me siento triste", category: .feeling),
    NeedItem(image: "happy", text: "Me siento feliz", category: .feeling),
    NeedItem(image: "anxious", text: "Me siento ansioso/a", category: .feeling),
    NeedItem(image: "scared", text: "Me siento asustado/a", category: .feeling),
    NeedItem(image: "jealous", text: "Me siento celoso/a", category: .feeling)
]

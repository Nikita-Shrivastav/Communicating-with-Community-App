import Foundation

/// French localization provider for the communication board
struct FrenchLocalizationProvider: LocalizationProvider {
    let displayName = "Français"
    let languageCode = "fr"
    let preferredVoiceCodes = ["fr-FR", "fr-CA", "fr-CH", "fr"]
    
    func categoryTitle(for category: ItemCategory) -> String {
        switch category {
        case .need: return "Besoins"
        case .want: return "Envies"
        case .feeling: return "Émotions"
        }
    }
    
    var wordBank: [String] {
        frenchWordBank
    }
    
    var items: [NeedItem] {
        frenchItems
    }
}

// French word bank for sentence builder
let frenchWordBank: [String] = [
    // Core pronouns / helpers
    "je", "tu", "nous", "ils", "elles", "il", "elle",
    "veux", "ai besoin", "ressens", "suis", "est", "sont",
    "à", "aller", "jouer", "manger", "boire", "voir", "trouver", "aider",
    "s'il vous plaît", "maintenant", "plus tard", "plus", "moins", "arrêter",
    
    // People
    "maman", "papa", "frère", "sœur",
    "professeur", "ami", "amie", "docteur", "infirmière",
    "grand-mère", "grand-père", "bébé", "famille",
    
    // Feelings
    "heureux", "heureuse", "triste", "en colère", "fatigué", "fatiguée", "effrayé", "effrayée",
    "blessé", "blessée", "excité", "excitée", "nerveux", "nerveuse", "inquiet", "inquiète", "calme",
    
    // Food & drinks
    "eau", "jus", "lait", "glace", "pizza", "sandwich",
    "riz", "pâtes", "nouilles", "pomme", "banane", "biscuit",
    "pain", "chips", "soupe", "céréales", "œuf",
    
    // Places
    "maison", "école", "dehors", "dedans", "toilettes",
    "cuisine", "parc", "voiture", "lit", "table",
    
    // Body parts
    "tête", "bras", "jambe", "main", "pied",
    "estomac", "dos", "œil", "oreille", "bouche",
    
    // Injuries / sensations
    "douleur", "démangeaison", "chaud", "froid",
    "saignement", "coupure", "bleu", "malade", "étourdi", "étourdie",
    "crampe", "entorse",
    
    // Actions
    "asseoir", "se lever", "marcher", "courir",
    "sauter", "dormir", "se reposer",
    "ouvrir", "fermer", "regarder", "toucher",
    "écouter", "attendre", "laver", "nettoyer",
    
    // Extras
    "oui", "non", "peut-être",
    "ceci", "cela", "là-bas", "ici",
    "le mien", "la mienne", "le tien", "la tienne",
    
    // Describing words
    "grand", "grande", "petit", "petite", "fort", "forte", "doux", "douce",
    "rapide", "lent", "lente", "bon", "bonne", "mauvais", "mauvaise",
    "froid", "froide", "chaud", "chaude", "tiède"
]

// French localized items for categories
let frenchItems: [NeedItem] = [
    // Needs (10 items)
    NeedItem(image: "water", text: "J'ai besoin d'eau", category: .need),
    NeedItem(image: "food", text: "J'ai besoin de manger", category: .need),
    NeedItem(image: "bed", text: "J'ai besoin de dormir", category: .need),
    NeedItem(image: "toilet", text: "J'ai besoin d'aller aux toilettes", category: .need),
    NeedItem(image: "help", text: "J'ai besoin d'aide", category: .need),
    NeedItem(image: "medicine", text: "J'ai besoin de médicaments", category: .need),
    NeedItem(image: "break", text: "J'ai besoin d'une pause", category: .need),
    NeedItem(image: "quiet", text: "J'ai besoin de calme", category: .need),
    NeedItem(image: "hug", text: "J'ai besoin d'un câlin", category: .need),
    NeedItem(image: "space", text: "J'ai besoin d'espace", category: .need),
    
    // Wants (10 items)
    NeedItem(image: "walk", text: "Je veux me promener", category: .want),
    NeedItem(image: "play", text: "Je veux jouer", category: .want),
    NeedItem(image: "mom", text: "Je veux maman", category: .want),
    NeedItem(image: "dad", text: "Je veux papa", category: .want),
    NeedItem(image: "brother", text: "Je veux mon frère", category: .want),
    NeedItem(image: "sister", text: "Je veux ma sœur", category: .want),
    NeedItem(image: "friend", text: "Je veux voir mon ami/amie", category: .want),
    NeedItem(image: "outside", text: "Je veux sortir dehors", category: .want),
    NeedItem(image: "watch", text: "Je veux regarder quelque chose", category: .want),
    NeedItem(image: "music", text: "Je veux écouter de la musique", category: .want),
    
    // Feelings (10 items)
    NeedItem(image: "mad", text: "Je me sens en colère", category: .feeling),
    NeedItem(image: "sad", text: "Je me sens triste", category: .feeling),
    NeedItem(image: "happy", text: "Je me sens heureux/heureuse", category: .feeling),
    NeedItem(image: "anxious", text: "Je me sens anxieux/anxieuse", category: .feeling),
    NeedItem(image: "scared", text: "Je me sens effrayé/effrayée", category: .feeling),
    NeedItem(image: "jealous", text: "Je me sens jaloux/jalouse", category: .feeling),
    NeedItem(image: "tired", text: "Je me sens fatigué/fatiguée", category: .feeling),
    NeedItem(image: "excited", text: "Je me sens excité/excitée", category: .feeling),
    NeedItem(image: "confused", text: "Je me sens confus/confuse", category: .feeling),
    NeedItem(image: "sick", text: "Je me sens malade", category: .feeling)
]


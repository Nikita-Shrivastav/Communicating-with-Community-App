# French Language Support

## Summary

French language support has been successfully added to the Communicating with Community app. Users can now select "Français" from the language picker and use the app entirely in French, including:

- All UI labels and buttons
- Category names (Besoins, Envies, Émotions)
- Pre-configured communication items
- Word bank for sentence building
- Text-to-speech in French

## Files Modified

### 1. **LocalizationFrench.swift** (New File)
Created a new French localization provider with:
- `FrenchLocalizationProvider` struct implementing the `LocalizationProvider` protocol
- French display name: "Français"
- Preferred voice codes: `["fr-FR", "fr-CA", "fr-CH", "fr"]` (France, Canada, Switzerland)
- Category titles:
  - Needs → "Besoins"
  - Wants → "Envies"
  - Feelings → "Émotions"
- `frenchWordBank`: 100+ French words for sentence building including:
  - Pronouns (je, tu, nous, ils, elles)
  - Actions (aller, jouer, manger, boire)
  - People (maman, papa, frère, sœur)
  - Feelings (heureux/heureuse, triste, en colère)
  - Food & drinks (eau, jus, lait, pizza)
  - And much more!
- `frenchItems`: 16 pre-configured communication items with French text

### 2. **Communicating_with_CommunityApp.swift**
Updated the main app file:
- Added `.french = "fr"` case to `AppLanguage` enum
- Updated `displayName` computed property to include `FrenchLocalizationProvider`
- Updated `preferredVoiceCodes` to include French voice preferences
- Updated `provider` computed property to return `FrenchLocalizationProvider()` when French is selected
- Added French language button to the language picker UI (purple button)

### 3. **Localizer.swift**
Enhanced the localization system:
- Added `frInlineFallback` dictionary with all French UI strings including:
  - Navigation: "Retour", "Informations", "Changer de Langue"
  - Categories: "Choisir une Catégorie", "Constructeur de Phrases"
  - Prompts and instructions
  - Sentence builder labels
- Updated `inlineFallback()` function to handle French language codes ("fr", "fr-FR", "fr-CA", etc.)
- Added French confirmation string to all language fallback dictionaries

## French Content

### Category Items (frenchItems)

**Besoins (Needs):**
- Je veux de l'eau
- Je veux manger
- Je veux dormir
- Je veux aller aux toilettes

**Envies (Wants):**
- Je veux me promener
- Je veux jouer
- Je veux maman
- Je veux papa
- Je veux mon frère
- Je veux ma sœur

**Émotions (Feelings):**
- Je me sens en colère
- Je me sens triste
- Je me sens heureux/heureuse
- Je me sens anxieux/anxieuse
- Je me sens effrayé/effrayée
- Je me sens jaloux/jalouse

### Word Bank Highlights

The French word bank includes over 100 words organized into categories:
- Core pronouns and helpers
- Family members and people
- Feelings and emotions
- Food and drinks
- Places
- Body parts
- Injuries and sensations
- Actions and verbs
- Descriptive words (with masculine and feminine forms where applicable)

## Text-to-Speech

The app will automatically use French text-to-speech voices in the following priority:
1. `fr-FR` (French - France)
2. `fr-CA` (French - Canada)
3. `fr-CH` (French - Switzerland)
4. `fr` (generic French)

## User Experience

When a user selects French:
1. A purple "Français" button appears in the language picker
2. Upon selection, the app announces "Français sélectionné" (French selected)
3. All UI elements display in French
4. The sentence builder includes French words with proper accents (é, è, ê, à, etc.)
5. Gender-specific words are included where appropriate (heureux/heureuse, grand/grande)

## Testing Recommendations

To test French language support:
1. Launch the app
2. Select the purple "Français" button
3. Navigate through categories (Besoins, Envies, Émotions)
4. Test the sentence builder with French words
5. Verify text-to-speech pronunciation
6. Test typed sentence input with French keyboard

## Notes

- French includes gendered adjectives (masculine/feminine forms) in the word bank
- Accented characters are properly included (é, è, ê, à, ô, etc.)
- The word bank is comprehensive enough for basic communication needs
- All 16 pre-configured items follow natural French sentence structure

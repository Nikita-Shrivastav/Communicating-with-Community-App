# Portuguese Language Manual Testing Checklist

## Overview
This document provides a comprehensive checklist for manually testing Portuguese language support in the Communicating with Community app.

## Pre-Testing Setup
- [ ] Build and run the app on a device or simulator
- [ ] Clear app data (delete and reinstall) to test fresh installation
- [ ] Ensure device has Portuguese text-to-speech voices installed (Settings > Accessibility > Spoken Content > Voices)

---

## Test 1: Language Selection Screen
### Main App Language Picker
- [ ] Launch the app for the first time
- [ ] Verify that 6 language buttons appear (English, हिन्दी, Español, 中文, Français, Português)
- [ ] **Check that "Português" button is visible** (should be in bottom row with French)
- [ ] Tap the "Português" button
- [ ] Verify that Portuguese selection confirmation is spoken: "Português selecionado"
- [ ] Verify that the app proceeds to the intro screen

### Expected Result
✅ Portuguese button appears in the language picker
✅ Tapping Portuguese selects it and speaks confirmation

---

## Test 2: Tutorial Language Picker
### In-Tutorial Language Selection
- [ ] Start the guided tutorial
- [ ] Tap the language/globe button in the top-right corner
- [ ] Verify language picker overlay appears
- [ ] **Verify "Português" button is visible** with 🇵🇹 flag
- [ ] Tap "Português"
- [ ] Verify the picker closes
- [ ] Verify tutorial content updates to Portuguese

### Expected Result
✅ Portuguese appears in tutorial language picker
✅ Selecting Portuguese updates tutorial content

---

## Test 3: Main Menu in Portuguese
### Category Buttons
- [ ] Select Portuguese language
- [ ] Navigate to main menu
- [ ] Verify category buttons display in Portuguese:
  - ❤️ "Necessidades" (Needs)
  - ⭐ "Desejos" (Wants)
  - 😊 "Sentimentos" (Feelings)
  - 💬 "Construtor de Frases" (Sentence Builder)

### Navigation Buttons
- [ ] Verify top buttons are in Portuguese:
  - "Tutorial Guiado" (Guided Tutorial)
  - "Informações" (Info)
  - "Mudar Idioma" (Change Language)

### Expected Result
✅ All menu items display in Portuguese
✅ Tapping categories speaks the Portuguese name

---

## Test 4: Needs Category (Necessidades)
### Portuguese Need Items
- [ ] Tap "Necessidades" category
- [ ] Verify 10 items appear with Portuguese text:
  - "Preciso de água" (I need water)
  - "Preciso de comida" (I need food)
  - "Preciso dormir" (I need to sleep)
  - "Preciso ir ao banheiro" (I need bathroom)
  - "Preciso de ajuda" (I need help)
  - "Preciso de remédio" (I need medicine)
  - "Preciso de uma pausa" (I need a break)
  - "Preciso de silêncio" (I need quiet)
  - "Preciso de um abraço" (I need a hug)
  - "Preciso de espaço" (I need space)

### Speech Test
- [ ] Tap each item
- [ ] Verify text-to-speech speaks the Portuguese phrase
- [ ] Verify audio quality and pronunciation

### Expected Result
✅ All 10 need items display in Portuguese
✅ All items speak correctly when tapped

---

## Test 5: Wants Category (Desejos)
### Portuguese Want Items
- [ ] Tap "Desejos" category
- [ ] Verify 10 items appear with Portuguese text:
  - "Quero passear" (I want to walk)
  - "Quero brincar" (I want to play)
  - "Quero a mamãe" (I want mom)
  - "Quero o papai" (I want dad)
  - "Quero meu irmão" (I want my brother)
  - "Quero minha irmã" (I want my sister)
  - "Quero ver meu/minha amigo/a" (I want to see my friend)
  - "Quero ir lá fora" (I want to go outside)
  - "Quero assistir a algo" (I want to watch something)
  - "Quero ouvir música" (I want to listen to music)

### Expected Result
✅ All 10 want items display in Portuguese
✅ All items speak correctly when tapped

---

## Test 6: Feelings Category (Sentimentos)
### Portuguese Feeling Items
- [ ] Tap "Sentimentos" category
- [ ] Verify 10 items appear with Portuguese text:
  - "Eu me sinto com raiva" (I feel mad)
  - "Eu me sinto triste" (I feel sad)
  - "Eu me sinto feliz" (I feel happy)
  - "Eu me sinto ansioso/ansiosa" (I feel anxious)
  - "Eu me sinto com medo" (I feel scared)
  - "Eu me sinto com ciúmes" (I feel jealous)
  - "Eu me sinto cansado/cansada" (I feel tired)
  - "Eu me sinto animado/animada" (I feel excited)
  - "Eu me sinto confuso/confusa" (I feel confused)
  - "Eu me sinto doente" (I feel sick)

### Expected Result
✅ All 10 feeling items display in Portuguese
✅ All items speak correctly when tapped

---

## Test 7: Sentence Builder - Word Bank
### Portuguese Word Bank
- [ ] Tap "Construtor de Frases"
- [ ] Scroll through word bank
- [ ] Verify Portuguese words appear, including:
  - Pronouns: "eu", "você", "nós", "eles"
  - Actions: "quero", "preciso", "ir", "ajudar"
  - Common words: "água", "comida", "casa", "escola"
  - Politeness: "por favor", "sim", "não"

### Building Sentences
- [ ] Tap words to build a sentence: "eu quero água por favor"
- [ ] Verify words appear in sentence area
- [ ] Tap "Falar" (Speak) button
- [ ] Verify sentence is spoken in Portuguese
- [ ] Tap "Limpar" (Clear) button
- [ ] Verify sentence clears

### Expected Result
✅ Word bank contains 90+ Portuguese words
✅ Can build sentences by tapping words
✅ Speak and clear functions work

---

## Test 8: Sentence Builder - Typing
### Portuguese Typing
- [ ] In Sentence Builder, find the typing section
- [ ] Verify label says "Digite Sua Frase" (Type Your Sentence)
- [ ] Verify placeholder says "Digite aqui" (Type here)
- [ ] Type a custom sentence: "Olá, como você está?"
- [ ] Tap "Falar" button
- [ ] Verify the typed sentence is spoken in Portuguese
- [ ] Tap "Limpar" button
- [ ] Verify text clears

### Expected Result
✅ Can type custom Portuguese text
✅ Typed text is spoken correctly
✅ Clear button works

---

## Test 9: Guided Tutorial in Portuguese
### Tutorial Steps
- [ ] Start the guided tutorial
- [ ] Select Portuguese language
- [ ] Go through all tutorial steps:
  1. Welcome ("Bem-vindo ao Aplicativo")
  2. Categories ("Escolher Categorias")
  3. Needs Demo ("Usar Necessidades")
  4. Sentence Builder ("Construtor de Frases")
  5. Word Bank ("Banco de Palavras")
  6. Typing ("Digitação")
  7. Completion ("Você Está Pronto!")

### Interactive Demos
- [ ] Step 3: Tap demo items (Água, Comida, Ajuda)
- [ ] Step 5: Build a sentence with demo words
- [ ] Step 6: Type and speak a custom sentence

### Audio Features
- [ ] Tap "Ouvir Este Passo" on each step
- [ ] Verify step description is read in Portuguese

### Expected Result
✅ All tutorial steps display in Portuguese
✅ Interactive demos work correctly
✅ Audio narration works in Portuguese

---

## Test 10: Language Switching
### Switching Between Languages
- [ ] Start with Portuguese selected
- [ ] Navigate to any screen (e.g., Needs category)
- [ ] Tap "Mudar Idioma" (Change Language)
- [ ] Switch to English
- [ ] Verify content updates to English
- [ ] Switch back to Portuguese
- [ ] Verify content returns to Portuguese

### Expected Result
✅ Can switch between languages seamlessly
✅ All content updates when language changes
✅ No crashes or layout issues

---

## Test 11: Emoji Support
### Word Bank Emojis
- [ ] In Portuguese word bank, verify emojis appear:
  - 💧 água (water)
  - 🍽️ comida (food)
  - 🏠 casa (home)
  - 🆘 ajuda (help)
  - 🙏 por favor (please)
  - 😊 feliz (happy)
  - 😢 triste (sad)

### Expected Result
✅ Common Portuguese words have corresponding emojis
✅ Emojis enhance visual understanding

---

## Test 12: Accessibility & Edge Cases
### Long Text Handling
- [ ] Verify long Portuguese phrases fit in buttons/cards
- [ ] Check that text doesn't overflow or get cut off
- [ ] Test on different device sizes (if possible)

### Voice Synthesis
- [ ] Verify Portuguese voices are clear and understandable
- [ ] Test both Brazilian (pt-BR) and European (pt-PT) if available
- [ ] Verify accent marks are pronounced correctly (água, está, será)

### Special Characters
- [ ] Verify Portuguese special characters display correctly:
  - ã, õ (tilde)
  - á, é, í, ó, ú (acute accent)
  - â, ê, ô (circumflex)
  - ç (cedilla)

### Expected Result
✅ Text layouts properly on all screens
✅ Portuguese voices work correctly
✅ Special characters display and speak correctly

---

## Test 13: App Store / Localization Completeness
### Check for Missing Translations
- [ ] Navigate through every screen in the app
- [ ] Look for any English text when Portuguese is selected
- [ ] Common places to check:
  - Alert dialogs
  - Error messages
  - Button labels
  - Navigation titles
  - Tutorial text

### Expected Result
✅ No English fallback text appears
✅ All UI elements are translated to Portuguese

---

## Test 14: Performance
### Loading & Responsiveness
- [ ] Select Portuguese language
- [ ] Navigate between screens
- [ ] Verify no lag or delays
- [ ] Verify speech synthesis starts promptly
- [ ] Check memory usage (no crashes)

### Expected Result
✅ Portuguese performs as well as other languages
✅ No performance degradation

---

## Summary Checklist

### Core Functionality
- [ ] Portuguese appears as an option in language pickers
- [ ] All 30 communication items work (10 needs, 10 wants, 10 feelings)
- [ ] Word bank contains 90+ Portuguese words
- [ ] Sentence builder works (both word selection and typing)
- [ ] Text-to-speech works in Portuguese
- [ ] Tutorial is fully translated

### Visual Verification
- [ ] All text displays properly (no overflow)
- [ ] Special characters (ã, ç, etc.) render correctly
- [ ] Emojis appear for common words
- [ ] Layout is clean on all screens

### Audio Verification
- [ ] Portuguese speech is clear and understandable
- [ ] Pronunciation is correct
- [ ] Volume and speed are appropriate

### Integration
- [ ] Can switch between Portuguese and other languages
- [ ] No crashes or errors when using Portuguese
- [ ] All features work as expected

---

## Bug Report Template
If you find any issues during testing, use this template:

```
**Issue**: [Brief description]
**Language**: Portuguese (pt)
**Screen**: [Which screen/feature]
**Steps to Reproduce**:
1. 
2. 
3. 

**Expected Behavior**: 
[What should happen]

**Actual Behavior**: 
[What actually happens]

**Screenshots**: 
[If applicable]
```

---

## Sign-Off

**Tester Name**: ___________________
**Date**: ___________________
**Device/Simulator**: ___________________
**iOS Version**: ___________________

**Overall Status**: ⬜ Pass  ⬜ Fail  ⬜ Pass with minor issues

**Notes**:
___________________________________________________________________
___________________________________________________________________
___________________________________________________________________

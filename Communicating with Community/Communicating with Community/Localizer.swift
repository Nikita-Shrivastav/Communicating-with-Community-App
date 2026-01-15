import Foundation

/// Runtime localizer that loads strings from a chosen language's .lproj bundle.
/// Usage: L("key", langCode)
struct Localizer {
    private static func strippedKeyForFallback(_ key: String) -> String? {
        let prefixes = ["prompt_", "label_", "title_", "button_", "menu_"]
        for p in prefixes {
            if key.hasPrefix(p) {
                return String(key.dropFirst(p.count))
            }
        }
        return nil
    }

    private static let hiInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "श्रेणी चुनें",
        "sentence_builder": "वाक्य बनाएं",
        "back": "वापस",
        "info": "जानकारी",
        "change_language": "भाषा बदलें",
        
        // Language selection
        "choose_language_title": "भाषा चुनें",
        "hear_prompt": "संकेत सुनें",
        "prompt_select_language": "कृपया एक भाषा चुनें",
        "confirm_language_selected_en": "अंग्रेज़ी चुनी गई है",
        "confirm_language_selected_hi": "हिन्दी चुनी गई है",
        "confirm_language_selected_es": "स्पेनिश चुनी गई है",
        "confirm_language_selected_zh": "चीनी चुनी गई है",
        "confirm_language_selected_fr": "फ़्रेंच चुनी गई है",
        "confirm_language_selected_pt": "पुर्तगाली चुनी गई है",
        
        // Intro screen
        "start_using_board": "बोर्ड का उपयोग शुरू करें",
        "hear_quick_summary": "त्वरित सारांश सुनें",
        "quick_summary_text": "यह ऐप लोगों को चित्रों पर टैप करके, शब्द चुनकर या टाइप करके उनकी आवश्यकताओं, इच्छाओं, भावनाओं और कस्टम वाक्यों को संप्रेषित करने में मदद करता है।",
        
        // Prompts
        "prompt_choose_category": "कृपया एक श्रेणी चुनें",
        "prompt_sentence_builder": "वाक्य बनाने के लिए शब्दों पर टैप करें या अपना वाक्य टाइप करें",
        "prompt_back_to_menu": "मुख्य मेनू पर वापस जा रहे हैं",
        "prompt_info": "जानकारी पृष्ठ खोल रहे हैं",
        "prompt_choose_words": "कृपया शब्द चुनें",
        "prompt_type_sentence": "कृपया एक वाक्य टाइप करें",
        
        // Sentence builder
        "title_word_bank_sentence": "वाक्य बनाने के लिए शब्दों पर टैप करें",
        "speak_word_bank": "शब्द बैंक बोलें",
        "clear_words": "शब्द साफ़ करें",
        "type_your_sentence": "अपना वाक्य टाइप करें",
        "type_here": "यहाँ टाइप करें",
        "speak_typed_sentence": "टाइप किया वाक्य बोलें",
        "clear": "साफ़ करें",
        "word_bank": "शब्द बैंक",
        
        // Main menu
        "menu_subtitle": "अपनी ज़रूरत साझा करने के लिए एक श्रेणी पर टैप करें",
        
        // Tutorial
        "tutorial_button": "निर्देशित ट्यूटोरियल",
        "tutorial_exit": "बाहर निकलें",
        "tutorial_step_indicator": "चरण %@ / %@",
        "tutorial_hear_step": "इस चरण को सुनें",
        "tutorial_try_it": "इसे आज़माएं",
        "tutorial_previous": "पिछला",
        "tutorial_next": "अगला",
        "tutorial_finish": "समाप्त करें",
        "tutorial_speak": "बोलें",
        "tutorial_clear": "साफ़ करें",
        "tutorial_language_change_note": "आप ट्यूटोरियल के दौरान किसी भी समय भाषा बदल सकते हैं",
        
        // Tutorial steps
        "tutorial_welcome_title": "ऐप में आपका स्वागत है",
        "tutorial_welcome_description": "यह ट्यूटोरियल आपको दिखाएगा कि संचार बोर्ड का उपयोग कैसे करें। आप अपनी आवश्यकताओं, इच्छाओं और भावनाओं को साझा करने के लिए चित्रों पर टैप कर सकते हैं, या वाक्य बनाने के लिए शब्दों को चुन सकते हैं।",
        
        "tutorial_categories_title": "श्रेणियाँ चुनें",
        "tutorial_categories_description": "मुख्य मेनू में तीन श्रेणियाँ हैं: आवश्यकताएँ (जैसे पानी, भोजन), इच्छाएँ (जैसे टहलना, किसी को फोन करना), और भावनाएँ (जैसे खुश, उदास, नाराज़)। इनमें से किसी एक पर टैप करें और डिवाइस इसे ज़ोर से बोलेगा।",
        
        "tutorial_needs_demo_title": "आवश्यकताओं का उपयोग करें",
        "tutorial_needs_demo_description": "आप जो कहना चाहते हैं उस चित्र पर टैप करें। डिवाइस तुरंत उस शब्द को बोलेगा। यह कोशिश करें!",
        
        "tutorial_sentence_builder_title": "वाक्य बनाने वाला",
        "tutorial_sentence_builder_description": "वाक्य बनाने वाला आपको अपने स्वयं के वाक्य बनाने देता है। आप दो तरीकों का उपयोग कर सकते हैं: शब्द बैंक से शब्दों पर टैप करना, या अपना खुद का वाक्य टाइप करना।",
        
        "tutorial_word_bank_title": "शब्द बैंक",
        "tutorial_word_bank_description": "शब्द बैंक में आम शब्दों की एक सूची है। वाक्य बनाने के लिए शब्दों पर टैप करें, फिर स्पीकर बटन दबाएं ताकि डिवाइस इसे ज़ोर से बोले।",
        
        "tutorial_typing_title": "टाइपिंग",
        "tutorial_typing_description": "यदि आप जो कहना चाहते हैं वह शब्द बैंक में नहीं है, तो आप कुछ भी टाइप कर सकते हैं! बस टेक्स्ट बॉक्स में अपना वाक्य टाइप करें और इसे ज़ोर से बोलने के लिए स्पीक बटन दबाएं।",
        
        "tutorial_completion_title": "आप तैयार हैं!",
        "tutorial_completion_description": "बढ़िया काम! अब आप ऐप का उपयोग करने के लिए तैयार हैं। याद रखें: आप कभी भी मुख्य मेनू में जानकारी बटन दबाकर इस ट्यूटोरियल पर वापस आ सकते हैं। संचार का आनंद लें!",
        "tutorial_completion_message": "ट्यूटोरियल पूरा हो गया! अब आप ऐप का उपयोग करने के लिए तैयार हैं।",
        
        // Tutorial demo
        "tutorial_tap_item": "आइटम पर टैप करें और सुनें",
        "tutorial_demo_water": "पानी",
        "tutorial_demo_food": "खाना",
        "tutorial_demo_help": "मदद",
        "tutorial_your_sentence": "आपका वाक्य",
        "tutorial_empty_sentence": "शब्द चुनना शुरू करें",
        "tutorial_tap_words": "वाक्य बनाने के लिए शब्दों पर टैप करें",
        "tutorial_type_anything": "कुछ भी टाइप करें और इसे ज़ोर से बोलें",
        "tutorial_type_here": "यहाँ टाइप करें",
        "tutorial_type_something_first": "कृपया पहले कुछ टाइप करें"
    ]
    
    private static let enInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "Choose Category",
        "sentence_builder": "Sentence Builder",
        "back": "Back",
        "info": "Info",
        "change_language": "Change Language",
        
        // Language selection
        "choose_language_title": "Choose Language",
        "hear_prompt": "Hear Prompt",
        "prompt_select_language": "Please select a language",
        "confirm_language_selected_en": "English selected",
        "confirm_language_selected_hi": "Hindi selected",
        "confirm_language_selected_es": "Spanish selected",
        "confirm_language_selected_zh": "Chinese selected",
        "confirm_language_selected_fr": "French selected",
        "confirm_language_selected_pt": "Portuguese selected",
        
        // Intro screen
        "start_using_board": "Start Using the Board",
        "hear_quick_summary": "Hear a Quick Summary",
        "quick_summary_text": "This app helps people communicate their needs, wants, feelings, and custom sentences by tapping pictures, choosing words, or typing.",
        
        // Prompts
        "prompt_choose_category": "Please choose a category",
        "prompt_sentence_builder": "Tap words to build a sentence or type your own sentence",
        "prompt_back_to_menu": "Returning to main menu",
        "prompt_info": "Opening information page",
        "prompt_choose_words": "Please choose words",
        "prompt_type_sentence": "Please type a sentence",
        
        // Sentence builder
        "title_word_bank_sentence": "Tap words to build a sentence",
        "speak_word_bank": "Speak Word Bank",
        "clear_words": "Clear Words",
        "type_your_sentence": "Type Your Sentence",
        "type_here": "Type here",
        "speak_typed_sentence": "Speak Typed Sentence",
        "clear": "Clear",
        "word_bank": "Word Bank",
        
        // Main menu
        "menu_subtitle": "Tap a category to share what you need",
        
        // Tutorial
        "tutorial_button": "Guided Tutorial",
        "tutorial_exit": "Exit",
        "tutorial_step_indicator": "Step %@ of %@",
        "tutorial_hear_step": "Hear This Step",
        "tutorial_try_it": "Try It",
        "tutorial_previous": "Previous",
        "tutorial_next": "Next",
        "tutorial_finish": "Finish",
        "tutorial_speak": "Speak",
        "tutorial_clear": "Clear",
        "tutorial_language_change_note": "You can change the language at any time during the tutorial",
        
        // Tutorial steps
        "tutorial_welcome_title": "Welcome to the App",
        "tutorial_welcome_description": "This tutorial will show you how to use the communication board. You can tap pictures to share your needs, wants, and feelings, or build sentences by choosing words.",
        
        "tutorial_categories_title": "Choose Categories",
        "tutorial_categories_description": "The main menu has three categories: Needs (like water, food), Wants (like going for a walk, calling someone), and Feelings (like happy, sad, angry). Tap any of these and the device will speak it out loud.",
        
        "tutorial_needs_demo_title": "Use Needs",
        "tutorial_needs_demo_description": "Tap a picture of what you want to say. The device will immediately speak that word. Try it!",
        
        "tutorial_sentence_builder_title": "Sentence Builder",
        "tutorial_sentence_builder_description": "The Sentence Builder lets you create your own sentences. You can use two methods: tapping words from the word bank, or typing your own sentence.",
        
        "tutorial_word_bank_title": "Word Bank",
        "tutorial_word_bank_description": "The word bank has a list of common words. Tap words to build a sentence, then press the speaker button to have the device say it out loud.",
        
        "tutorial_typing_title": "Typing",
        "tutorial_typing_description": "If what you want to say is not in the word bank, you can type anything! Just type your sentence in the text box and press the speak button to have it spoken aloud.",
        
        "tutorial_completion_title": "You're Ready!",
        "tutorial_completion_description": "Great job! You're now ready to use the app. Remember: you can always come back to this tutorial by pressing the info button in the main menu. Enjoy communicating!",
        "tutorial_completion_message": "Tutorial complete! You're now ready to use the app.",
        
        // Tutorial demo
        "tutorial_tap_item": "Tap an item to hear it",
        "tutorial_demo_water": "Water",
        "tutorial_demo_food": "Food",
        "tutorial_demo_help": "Help",
        "tutorial_your_sentence": "Your Sentence",
        "tutorial_empty_sentence": "Start choosing words",
        "tutorial_tap_words": "Tap words to build a sentence",
        "tutorial_type_anything": "Type anything and hear it spoken",
        "tutorial_type_here": "Type here",
        "tutorial_type_something_first": "Please type something first"
    ]
    
    private static let esInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "Elegir Categoría",
        "sentence_builder": "Constructor de Oraciones",
        "back": "Atrás",
        "info": "Información",
        "change_language": "Cambiar Idioma",
        
        // Language selection
        "choose_language_title": "Elegir Idioma",
        "hear_prompt": "Escuchar Indicación",
        "prompt_select_language": "Por favor seleccione un idioma",
        "confirm_language_selected_en": "Inglés seleccionado",
        "confirm_language_selected_hi": "Hindi seleccionado",
        "confirm_language_selected_es": "Español seleccionado",
        "confirm_language_selected_zh": "Chino seleccionado",
        "confirm_language_selected_fr": "Francés seleccionado",
        "confirm_language_selected_pt": "Portugués seleccionado",
        
        // Intro screen
        "start_using_board": "Comenzar a Usar el Tablero",
        "hear_quick_summary": "Escuchar Resumen Rápido",
        "quick_summary_text": "Esta aplicación ayuda a las personas a comunicar sus necesidades, deseos, sentimientos y oraciones personalizadas tocando imágenes, eligiendo palabras o escribiendo.",
        
        // Prompts
        "prompt_choose_category": "Por favor elija una categoría",
        "prompt_sentence_builder": "Toque palabras para construir una oración o escriba su propia oración",
        "prompt_back_to_menu": "Regresando al menú principal",
        "prompt_info": "Abriendo página de información",
        "prompt_choose_words": "Por favor elija palabras",
        "prompt_type_sentence": "Por favor escriba una oración",
        
        // Sentence builder
        "title_word_bank_sentence": "Toque palabras para construir una oración",
        "speak_word_bank": "Hablar Banco de Palabras",
        "clear_words": "Borrar Palabras",
        "type_your_sentence": "Escriba su Oración",
        "type_here": "Escriba aquí",
        "speak_typed_sentence": "Hablar Oración Escrita",
        "clear": "Borrar",
        "word_bank": "Banco de Palabras",
        
        // Main menu
        "menu_subtitle": "Toque una categoría para compartir lo que necesita",
        
        // Tutorial
        "tutorial_button": "Tutorial Guiado",
        "tutorial_exit": "Salir",
        "tutorial_step_indicator": "Paso %@ de %@",
        "tutorial_hear_step": "Escuchar Este Paso",
        "tutorial_try_it": "Pruébalo",
        "tutorial_previous": "Anterior",
        "tutorial_next": "Siguiente",
        "tutorial_finish": "Finalizar",
        "tutorial_speak": "Hablar",
        "tutorial_clear": "Borrar",
        "tutorial_language_change_note": "Puede cambiar el idioma en cualquier momento durante el tutorial",
        
        // Tutorial steps
        "tutorial_welcome_title": "Bienvenido a la Aplicación",
        "tutorial_welcome_description": "Este tutorial le mostrará cómo usar el tablero de comunicación. Puede tocar imágenes para compartir sus necesidades, deseos y sentimientos, o construir oraciones eligiendo palabras.",
        
        "tutorial_categories_title": "Elegir Categorías",
        "tutorial_categories_description": "El menú principal tiene tres categorías: Necesidades (como agua, comida), Deseos (como salir a caminar, llamar a alguien), y Sentimientos (como feliz, triste, enojado). Toque cualquiera de estos y el dispositivo lo dirá en voz alta.",
        
        "tutorial_needs_demo_title": "Usar Necesidades",
        "tutorial_needs_demo_description": "Toque una imagen de lo que desea decir. El dispositivo dirá inmediatamente esa palabra. ¡Inténtalo!",
        
        "tutorial_sentence_builder_title": "Constructor de Oraciones",
        "tutorial_sentence_builder_description": "El Constructor de Oraciones le permite crear sus propias oraciones. Puede usar dos métodos: tocar palabras del banco de palabras o escribir su propia oración.",
        
        "tutorial_word_bank_title": "Banco de Palabras",
        "tutorial_word_bank_description": "El banco de palabras tiene una lista de palabras comunes. Toque palabras para construir una oración, luego presione el botón de altavoz para que el dispositivo lo diga en voz alta.",
        
        "tutorial_typing_title": "Escribir",
        "tutorial_typing_description": "Si lo que quiere decir no está en el banco de palabras, ¡puede escribir cualquier cosa! Simplemente escriba su oración en el cuadro de texto y presione el botón hablar para que se diga en voz alta.",
        
        "tutorial_completion_title": "¡Está Listo!",
        "tutorial_completion_description": "¡Excelente trabajo! Ahora está listo para usar la aplicación. Recuerde: siempre puede volver a este tutorial presionando el botón de información en el menú principal. ¡Disfrute comunicándose!",
        "tutorial_completion_message": "¡Tutorial completo! Ahora está listo para usar la aplicación.",
        
        // Tutorial demo
        "tutorial_tap_item": "Toque un elemento para escucharlo",
        "tutorial_demo_water": "Agua",
        "tutorial_demo_food": "Comida",
        "tutorial_demo_help": "Ayuda",
        "tutorial_your_sentence": "Su Oración",
        "tutorial_empty_sentence": "Comience a elegir palabras",
        "tutorial_tap_words": "Toque palabras para construir una oración",
        "tutorial_type_anything": "Escriba cualquier cosa y escúchela hablada",
        "tutorial_type_here": "Escriba aquí",
        "tutorial_type_something_first": "Por favor escriba algo primero"
    ]
    
    private static let zhInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "选择类别",
        "sentence_builder": "句子构建器",
        "back": "返回",
        "info": "信息",
        "change_language": "更改语言",
        
        // Language selection
        "choose_language_title": "选择语言",
        "hear_prompt": "听提示",
        "prompt_select_language": "请选择一种语言",
        "confirm_language_selected_en": "已选择英语",
        "confirm_language_selected_hi": "已选择印地语",
        "confirm_language_selected_es": "已选择西班牙语",
        "confirm_language_selected_zh": "已选择中文",
        "confirm_language_selected_fr": "已选择法语",
        "confirm_language_selected_pt": "已选择葡萄牙语",
        
        // Intro screen
        "start_using_board": "开始使用看板",
        "hear_quick_summary": "听快速摘要",
        "quick_summary_text": "此应用程序通过点击图片、选择单词或打字来帮助人们表达他们的需求、愿望、感受和自定义句子。",
        
        // Prompts
        "prompt_choose_category": "请选择一个类别",
        "prompt_sentence_builder": "点击单词来构建句子或输入您自己的句子",
        "prompt_back_to_menu": "返回主菜单",
        "prompt_info": "打开信息页面",
        "prompt_choose_words": "请选择单词",
        "prompt_type_sentence": "请输入一个句子",
        
        // Sentence builder
        "title_word_bank_sentence": "点击单词来构建句子",
        "speak_word_bank": "朗读词库",
        "clear_words": "清除单词",
        "type_your_sentence": "输入您的句子",
        "type_here": "在此输入",
        "speak_typed_sentence": "朗读输入的句子",
        "clear": "清除",
        "word_bank": "词库",
        
        // Main menu
        "menu_subtitle": "点击类别以分享您的需求",
        
        // Tutorial
        "tutorial_button": "指导教程",
        "tutorial_exit": "退出",
        "tutorial_step_indicator": "第 %@ 步，共 %@ 步",
        "tutorial_hear_step": "听此步骤",
        "tutorial_try_it": "试一试",
        "tutorial_previous": "上一步",
        "tutorial_next": "下一步",
        "tutorial_finish": "完成",
        "tutorial_speak": "朗读",
        "tutorial_clear": "清除",
        "tutorial_language_change_note": "您可以在教程期间随时更改语言",
        
        // Tutorial steps
        "tutorial_welcome_title": "欢迎使用应用",
        "tutorial_welcome_description": "本教程将向您展示如何使用沟通板。您可以点击图片来分享您的需求、愿望和感受，或通过选择单词来构建句子。",
        
        "tutorial_categories_title": "选择类别",
        "tutorial_categories_description": "主菜单有三个类别：需求（如水、食物）、愿望（如散步、打电话给某人）和感受（如快乐、悲伤、生气）。点击其中任何一个，设备将大声朗读。",
        
        "tutorial_needs_demo_title": "使用需求",
        "tutorial_needs_demo_description": "点击您想说的图片。设备将立即说出该单词。试试看！",
        
        "tutorial_sentence_builder_title": "句子构建器",
        "tutorial_sentence_builder_description": "句子构建器让您创建自己的句子。您可以使用两种方法：从词库中点击单词，或输入自己的句子。",
        
        "tutorial_word_bank_title": "词库",
        "tutorial_word_bank_description": "词库中有常用单词列表。点击单词构建句子，然后按扬声器按钮让设备大声朗读。",
        
        "tutorial_typing_title": "输入",
        "tutorial_typing_description": "如果您想说的话不在词库中，您可以输入任何内容！只需在文本框中输入您的句子，然后按朗读按钮即可大声朗读。",
        
        "tutorial_completion_title": "您准备好了！",
        "tutorial_completion_description": "做得好！您现在可以使用该应用了。记住：您可以随时通过按主菜单中的信息按钮返回本教程。享受沟通！",
        "tutorial_completion_message": "教程完成！您现在可以使用该应用了。",
        
        // Tutorial demo
        "tutorial_tap_item": "点击项目以听到它",
        "tutorial_demo_water": "水",
        "tutorial_demo_food": "食物",
        "tutorial_demo_help": "帮助",
        "tutorial_your_sentence": "您的句子",
        "tutorial_empty_sentence": "开始选择单词",
        "tutorial_tap_words": "点击单词来构建句子",
        "tutorial_type_anything": "输入任何内容并听到它朗读",
        "tutorial_type_here": "在此输入",
        "tutorial_type_something_first": "请先输入内容"
    ]
    
    private static let frInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "Choisir une Catégorie",
        "sentence_builder": "Constructeur de Phrases",
        "back": "Retour",
        "info": "Informations",
        "change_language": "Changer de Langue",
        
        // Language selection
        "choose_language_title": "Choisir la Langue",
        "hear_prompt": "Écouter l'Invite",
        "prompt_select_language": "Veuillez sélectionner une langue",
        "confirm_language_selected_en": "Anglais sélectionné",
        "confirm_language_selected_hi": "Hindi sélectionné",
        "confirm_language_selected_es": "Espagnol sélectionné",
        "confirm_language_selected_zh": "Chinois sélectionné",
        "confirm_language_selected_fr": "Français sélectionné",
        "confirm_language_selected_pt": "Portugais sélectionné",
        
        // Intro screen
        "start_using_board": "Commencer à Utiliser le Tableau",
        "hear_quick_summary": "Écouter un Résumé Rapide",
        "quick_summary_text": "Cette application aide les personnes à communiquer leurs besoins, envies, émotions et phrases personnalisées en touchant des images, en choisissant des mots ou en tapant.",
        
        // Prompts
        "prompt_choose_category": "Veuillez choisir une catégorie",
        "prompt_sentence_builder": "Touchez les mots pour construire une phrase ou tapez votre propre phrase",
        "prompt_back_to_menu": "Retour au menu principal",
        "prompt_info": "Ouverture de la page d'informations",
        "prompt_choose_words": "Veuillez choisir des mots",
        "prompt_type_sentence": "Veuillez taper une phrase",
        
        // Sentence builder
        "title_word_bank_sentence": "Touchez les mots pour construire une phrase",
        "speak_word_bank": "Prononcer la Banque de Mots",
        "clear_words": "Effacer les Mots",
        "type_your_sentence": "Tapez Votre Phrase",
        "type_here": "Tapez ici",
        "speak_typed_sentence": "Prononcer la Phrase Tapée",
        "clear": "Effacer",
        "word_bank": "Banque de Mots",
        
        // Main menu
        "menu_subtitle": "Touchez une catégorie pour partager ce dont vous avez besoin",
        
        // Tutorial
        "tutorial_button": "Tutoriel Guidé",
        "tutorial_exit": "Quitter",
        "tutorial_step_indicator": "Étape %@ sur %@",
        "tutorial_hear_step": "Écouter Cette Étape",
        "tutorial_try_it": "Essayez-le",
        "tutorial_previous": "Précédent",
        "tutorial_next": "Suivant",
        "tutorial_finish": "Terminer",
        "tutorial_speak": "Prononcer",
        "tutorial_clear": "Effacer",
        "tutorial_language_change_note": "Vous pouvez changer de langue à tout moment pendant le tutoriel",
        
        // Tutorial steps
        "tutorial_welcome_title": "Bienvenue dans l'Application",
        "tutorial_welcome_description": "Ce tutoriel vous montrera comment utiliser le tableau de communication. Vous pouvez toucher les images pour partager vos besoins, envies et émotions, ou construire des phrases en choisissant des mots.",
        
        "tutorial_categories_title": "Choisir les Catégories",
        "tutorial_categories_description": "Le menu principal a trois catégories : Besoins (comme l'eau, la nourriture), Envies (comme se promener, appeler quelqu'un), et Émotions (comme heureux, triste, en colère). Touchez l'une d'elles et l'appareil la prononcera à voix haute.",
        
        "tutorial_needs_demo_title": "Utiliser les Besoins",
        "tutorial_needs_demo_description": "Touchez une image de ce que vous voulez dire. L'appareil prononcera immédiatement ce mot. Essayez !",
        
        "tutorial_sentence_builder_title": "Constructeur de Phrases",
        "tutorial_sentence_builder_description": "Le Constructeur de Phrases vous permet de créer vos propres phrases. Vous pouvez utiliser deux méthodes : toucher les mots de la banque de mots, ou taper votre propre phrase.",
        
        "tutorial_word_bank_title": "Banque de Mots",
        "tutorial_word_bank_description": "La banque de mots contient une liste de mots courants. Touchez les mots pour construire une phrase, puis appuyez sur le bouton haut-parleur pour que l'appareil la prononce à voix haute.",
        
        "tutorial_typing_title": "Saisie",
        "tutorial_typing_description": "Si ce que vous voulez dire n'est pas dans la banque de mots, vous pouvez taper n'importe quoi ! Tapez simplement votre phrase dans la zone de texte et appuyez sur le bouton prononcer pour la faire prononcer à voix haute.",
        
        "tutorial_completion_title": "Vous Êtes Prêt !",
        "tutorial_completion_description": "Excellent travail ! Vous êtes maintenant prêt à utiliser l'application. N'oubliez pas : vous pouvez toujours revenir à ce tutoriel en appuyant sur le bouton d'informations dans le menu principal. Profitez de la communication !",
        "tutorial_completion_message": "Tutoriel terminé ! Vous êtes maintenant prêt à utiliser l'application.",
        
        // Tutorial demo
        "tutorial_tap_item": "Touchez un élément pour l'entendre",
        "tutorial_demo_water": "Eau",
        "tutorial_demo_food": "Nourriture",
        "tutorial_demo_help": "Aide",
        "tutorial_your_sentence": "Votre Phrase",
        "tutorial_empty_sentence": "Commencez à choisir des mots",
        "tutorial_tap_words": "Touchez les mots pour construire une phrase",
        "tutorial_type_anything": "Tapez n'importe quoi et écoutez-le prononcé",
        "tutorial_type_here": "Tapez ici",
        "tutorial_type_something_first": "Veuillez taper quelque chose d'abord"
    ]
    
    private static let ptInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "Escolher Categoria",
        "sentence_builder": "Construtor de Frases",
        "back": "Voltar",
        "info": "Informações",
        "change_language": "Mudar Idioma",
        
        // Language selection
        "choose_language_title": "Escolher Idioma",
        "hear_prompt": "Ouvir Prompt",
        "prompt_select_language": "Por favor, selecione um idioma",
        "confirm_language_selected_en": "Inglês selecionado",
        "confirm_language_selected_hi": "Hindi selecionado",
        "confirm_language_selected_es": "Espanhol selecionado",
        "confirm_language_selected_zh": "Chinês selecionado",
        "confirm_language_selected_fr": "Francês selecionado",
        "confirm_language_selected_pt": "Português selecionado",
        
        // Intro screen
        "start_using_board": "Começar a Usar o Quadro",
        "hear_quick_summary": "Ouvir Resumo Rápido",
        "quick_summary_text": "Este aplicativo ajuda as pessoas a comunicar suas necessidades, desejos, sentimentos e frases personalizadas tocando em imagens, escolhendo palavras ou digitando.",
        
        // Prompts
        "prompt_choose_category": "Por favor, escolha uma categoria",
        "prompt_sentence_builder": "Toque nas palavras para construir uma frase ou digite sua própria frase",
        "prompt_back_to_menu": "Voltando ao menu principal",
        "prompt_info": "Abrindo a página de informações",
        "prompt_choose_words": "Por favor, escolha as palavras",
        "prompt_type_sentence": "Por favor, digite uma frase",
        
        // Sentence builder
        "title_word_bank_sentence": "Toque nas palavras para construir uma frase",
        "speak_word_bank": "Falar Banco de Palavras",
        "clear_words": "Limpar Palavras",
        "type_your_sentence": "Digite Sua Frase",
        "type_here": "Digite aqui",
        "speak_typed_sentence": "Falar Frase Digitada",
        "clear": "Limpar",
        "word_bank": "Banco de Palavras",
        
        // Main menu
        "menu_subtitle": "Toque em uma categoria para compartilhar o que você precisa",
        
        // Tutorial
        "tutorial_button": "Tutorial Guiado",
        "tutorial_exit": "Sair",
        "tutorial_step_indicator": "Passo %@ de %@",
        "tutorial_hear_step": "Ouvir Este Passo",
        "tutorial_try_it": "Experimente",
        "tutorial_previous": "Anterior",
        "tutorial_next": "Próximo",
        "tutorial_finish": "Concluir",
        "tutorial_speak": "Falar",
        "tutorial_clear": "Limpar",
        "tutorial_language_change_note": "Você pode mudar o idioma a qualquer momento durante o tutorial",
        
        // Tutorial steps
        "tutorial_welcome_title": "Bem-vindo ao Aplicativo",
        "tutorial_welcome_description": "Este tutorial mostrará como usar o quadro de comunicação. Você pode tocar em imagens para compartilhar suas necessidades, desejos e sentimentos, ou construir frases escolhendo palavras.",
        
        "tutorial_categories_title": "Escolher Categorias",
        "tutorial_categories_description": "O menu principal tem três categorias: Necessidades (como água, comida), Desejos (como fazer uma caminhada, ligar para alguém) e Emoções (como feliz, triste, irritado). Toque em uma delas e o dispositivo falará em voz alta.",
        
        "tutorial_needs_demo_title": "Usar Necessidades",
        "tutorial_needs_demo_description": "Toque em uma imagem do que você quer dizer. O dispositivo falará essa palavra imediatamente. Experimente!",
        
        "tutorial_sentence_builder_title": "Construtor de Frases",
        "tutorial_sentence_builder_description": "O Construtor de Frases permite que você crie suas próprias frases. Você pode usar dois métodos: tocar nas palavras do banco de palavras ou digitar sua própria frase.",
        
        "tutorial_word_bank_title": "Banco de Palavras",
        "tutorial_word_bank_description": "O banco de palavras contém uma lista de palavras comuns. Toque nas palavras para construir uma frase e, em seguida, pressione o botão de alto-falante para que o dispositivo fale em voz alta.",
        
        "tutorial_typing_title": "Digitação",
        "tutorial_typing_description": "Se o que você quer dizer não está no banco de palavras, você pode digitar qualquer coisa! Basta digitar sua frase na caixa de texto e pressionar o botão falar para que seja falada em voz alta.",
        
        "tutorial_completion_title": "Você Está Pronto!",
        "tutorial_completion_description": "Ótimo trabalho! Agora você está pronto para usar o aplicativo. Lembre-se: você sempre pode voltar a este tutorial pressionando o botão de informações no menu principal. Aproveite a comunicação!",
        "tutorial_completion_message": "Tutorial concluído! Agora você está pronto para usar o aplicativo.",
        
        // Tutorial demo
        "tutorial_tap_item": "Toque em um item para ouvi-lo",
        "tutorial_demo_water": "Água",
        "tutorial_demo_food": "Comida",
        "tutorial_demo_help": "Ajuda",
        "tutorial_your_sentence": "Sua Frase",
        "tutorial_empty_sentence": "Comece a escolher palavras",
        "tutorial_tap_words": "Toque nas palavras para construir uma frase",
        "tutorial_type_anything": "Digite qualquer coisa e ouça-a falada",
        "tutorial_type_here": "Digite aqui",
        "tutorial_type_something_first": "Por favor, digite algo primeiro"
    ]

    private static func inlineFallback(for key: String, code: String?) -> String? {
        guard let code = code?.lowercased() else { return nil }
        
        if code == "hi" || code.hasPrefix("hi-") {
            if let v = hiInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = hiInlineFallback[stripped] { return v2 }
        } else if code == "en" || code.hasPrefix("en-") {
            if let v = enInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = enInlineFallback[stripped] { return v2 }
        } else if code == "es" || code.hasPrefix("es-") {
            if let v = esInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = esInlineFallback[stripped] { return v2 }
        } else if code == "zh" || code.hasPrefix("zh-") {
            if let v = zhInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = zhInlineFallback[stripped] { return v2 }
        } else if code == "fr" || code.hasPrefix("fr-") {
            if let v = frInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = frInlineFallback[stripped] { return v2 }
        } else if code == "pt" || code.hasPrefix("pt-") {
            if let v = ptInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = ptInlineFallback[stripped] { return v2 }
        }
        
        return nil
    }

    private static func resolveKey(_ key: String, code: String?, table: String) -> String? {
        // 1) Try explicitly requested language (full code), then its short form
        if let c = code {
            if let b = bundle(for: c), let v = lookup(key, in: b, table: table) { return v }
            if let short = c.split(separator: "-").first.map(String.init), short != c,
               let b2 = bundle(for: short), let v2 = lookup(key, in: b2, table: table) { return v2 }
        }
        // 2) Base
        if let base = baseBundle(), let vBase = lookup(key, in: base, table: table) { return vBase }
        // 3) English
        if let en = englishBundle(), let vEn = lookup(key, in: en, table: table) { return vEn }
        // 4) Main/system
        let systemValue = NSLocalizedString(key, tableName: table, bundle: .main, value: missingSentinel, comment: "")
        if systemValue != missingSentinel { return systemValue }
        return nil
    }

    static func localized(_ key: String, languageCode: String?) -> String {
        // Normalize empty or whitespace-only codes to nil
        let normalizedCode: String? = {
            guard let c = languageCode?.trimmingCharacters(in: .whitespacesAndNewlines), !c.isEmpty else { return nil }
            return c
        }()

        let table = "Localizable"

        // Helper to try a key in a specific language code (full then short)
        func tryInLanguage(_ key: String, code: String) -> String? {
            if let b = bundle(for: code), let v = lookup(key, in: b, table: table) { return v }
            if let short = code.split(separator: "-").first.map(String.init), short != code,
               let b2 = bundle(for: short), let v2 = lookup(key, in: b2, table: table) { return v2 }
            return nil
        }

        // 1) Try requested language (exact key)
        if let code = normalizedCode, let v = tryInLanguage(key, code: code) {
            return v
        }

        // 2) If key has a known prefix, try stripped key in requested language
        if let code = normalizedCode, let stripped = strippedKeyForFallback(key), let v = tryInLanguage(stripped, code: code) {
            return v
        }

        // 3) Inline fallback for the requested language (before falling back to English)
        if let inline = inlineFallback(for: key, code: normalizedCode) { return inline }

        // 4) Base localization
        if let base = baseBundle(), let vBase = lookup(key, in: base, table: table) { return vBase }
        if let stripped = strippedKeyForFallback(key), let base = baseBundle(), let vBase2 = lookup(stripped, in: base, table: table) { return vBase2 }

        // 5) English localization
        if let en = englishBundle(), let vEn = lookup(key, in: en, table: table) { return vEn }
        if let stripped = strippedKeyForFallback(key), let en = englishBundle(), let vEn2 = lookup(stripped, in: en, table: table) { return vEn2 }

        // 6) System/main bundle
        let systemValue = NSLocalizedString(key, tableName: table, bundle: .main, value: missingSentinel, comment: "")
        if systemValue != missingSentinel { return systemValue }
        if let stripped = strippedKeyForFallback(key) {
            let systemValue2 = NSLocalizedString(stripped, tableName: table, bundle: .main, value: missingSentinel, comment: "")
            if systemValue2 != missingSentinel { return systemValue2 }
        }

        // 7) Last resort: humanize stripped key if available
        let toHumanize = strippedKeyForFallback(key) ?? key
        return humanizedKey(from: toHumanize)
    }

    private static let missingSentinel = "⟪MISSING_LOCALIZED_VALUE⟫"

    private static func lookup(_ key: String, in bundle: Bundle, table: String) -> String? {
        let value = NSLocalizedString(key, tableName: table, bundle: bundle, value: missingSentinel, comment: "")
        return value == missingSentinel ? nil : value
    }

    private static func humanizedKey(from key: String) -> String {
        let baseKey = strippedKeyForFallback(key) ?? key
        let spaced = baseKey.replacingOccurrences(of: "_", with: " ")
        guard let first = spaced.first else { return baseKey }
        return String(first).uppercased() + spaced.dropFirst()
    }

    private static func baseBundle() -> Bundle? {
        if let path = Bundle.main.path(forResource: "Base", ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle
        }
        return nil
    }

    private static func bundle(for languageCode: String) -> Bundle? {
        // Normalize codes like "en-US" -> "en" and "hi-IN" -> "hi"
        let short = languageCode.split(separator: "-").first.map(String.init) ?? languageCode
        // Prefer full code first, then short code
        let preferredCodes = [languageCode, short]
        for code in preferredCodes {
            if let path = Bundle.main.path(forResource: code, ofType: "lproj"), let bundle = Bundle(path: path) {
                return bundle
            }
        }
        return nil
    }

    private static func englishBundle() -> Bundle? {
        if let path = Bundle.main.path(forResource: "en", ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle
        }
        return nil
    }
}

extension Localizer {
    static func string(_ key: String, langCode: String?) -> String {
        localized(key, languageCode: langCode)
    }
}

/// Convenience free function for brevity
@inline(__always)
func L(_ key: String, _ languageCode: String?) -> String {
    Localizer.localized(key, languageCode: languageCode)
}

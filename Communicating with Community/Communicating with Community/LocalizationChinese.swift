import Foundation

/// Chinese (Simplified) localization provider for the communication board
struct ChineseLocalizationProvider: LocalizationProvider {
    let displayName = "中文"
    let languageCode = "zh"
    let preferredVoiceCodes = ["zh-CN", "zh-Hans", "zh-Hans-CN", "zh"]
    
    func categoryTitle(for category: NeedItem.Category) -> String {
        switch category {
        case .need: return "需求"
        case .want: return "想要"
        case .feeling: return "感受"
        }
    }
    
    var wordBank: [String] {
        chineseWordBank
    }
    
    var items: [NeedItem] {
        chineseItems
    }
}

// Chinese word bank for sentence builder
let chineseWordBank: [String] = [
    // Core pronouns / helpers
    "我", "你", "我们", "他们", "他", "她",
    "想要", "需要", "感到", "是", "在", "有",
    "去", "玩", "吃", "喝", "看", "找", "帮助",
    "请", "现在", "以后", "更多", "更少", "停",
    
    // People
    "妈妈", "爸爸", "哥哥", "姐姐", "弟弟", "妹妹",
    "老师", "朋友", "医生", "护士",
    "奶奶", "爷爷", "宝宝", "家人",
    
    // Feelings
    "开心", "难过", "生气", "累", "害怕",
    "疼", "兴奋", "紧张", "担心", "平静",
    
    // Food & drinks
    "水", "果汁", "牛奶", "冰淇淋", "披萨", "三明治",
    "米饭", "意大利面", "面条", "苹果", "香蕉", "饼干",
    "面包", "薯片", "汤", "麦片", "鸡蛋",
    
    // Places
    "家", "学校", "外面", "里面", "厕所",
    "厨房", "公园", "车", "床", "桌子",
    
    // Body parts
    "头", "胳膊", "腿", "手", "脚",
    "肚子", "背", "眼睛", "耳朵", "嘴",
    
    // Injuries / sensations
    "疼痛", "痒", "热", "冷",
    "流血", "伤口", "淤青", "生病", "头晕",
    "抽筋", "扭伤",
    
    // Actions
    "坐", "站", "走", "跑",
    "跳", "睡", "休息",
    "打开", "关", "看", "摸",
    "听", "等", "洗", "打扫",
    
    // Extras
    "是", "不是", "也许",
    "这个", "那个", "那里", "这里",
    "我的", "你的",
    
    // Describing words
    "大", "小", "响", "安静",
    "快", "慢", "好", "坏",
    "冷", "热", "温暖"
]

// Chinese localized items for categories
let chineseItems: [NeedItem] = [
    // Needs (10 items)
    NeedItem(image: "water", text: "我需要喝水", category: .need),
    NeedItem(image: "food", text: "我需要吃东西", category: .need),
    NeedItem(image: "bed", text: "我需要睡觉", category: .need),
    NeedItem(image: "toilet", text: "我需要上厕所", category: .need),
    NeedItem(image: "help", text: "我需要帮助", category: .need),
    NeedItem(image: "medicine", text: "我需要药", category: .need),
    NeedItem(image: "break", text: "我需要休息", category: .need),
    NeedItem(image: "quiet", text: "我需要安静", category: .need),
    NeedItem(image: "hug", text: "我需要拥抱", category: .need),
    NeedItem(image: "space", text: "我需要空间", category: .need),
    
    // Wants (10 items)
    NeedItem(image: "walk", text: "我想去散步", category: .want),
    NeedItem(image: "play", text: "我想玩", category: .want),
    NeedItem(image: "mom", text: "我想要妈妈", category: .want),
    NeedItem(image: "dad", text: "我想要爸爸", category: .want),
    NeedItem(image: "brother", text: "我想要哥哥/弟弟", category: .want),
    NeedItem(image: "sister", text: "我想要姐姐/妹妹", category: .want),
    NeedItem(image: "friend", text: "我想见朋友", category: .want),
    NeedItem(image: "outside", text: "我想出去", category: .want),
    NeedItem(image: "watch", text: "我想看东西", category: .want),
    NeedItem(image: "music", text: "我想听音乐", category: .want),
    
    // Feelings (10 items)
    NeedItem(image: "mad", text: "我感到生气", category: .feeling),
    NeedItem(image: "sad", text: "我感到难过", category: .feeling),
    NeedItem(image: "happy", text: "我感到开心", category: .feeling),
    NeedItem(image: "anxious", text: "我感到焦虑", category: .feeling),
    NeedItem(image: "scared", text: "我感到害怕", category: .feeling),
    NeedItem(image: "jealous", text: "我感到嫉妒", category: .feeling),
    NeedItem(image: "tired", text: "我感到疲倦", category: .feeling),
    NeedItem(image: "excited", text: "我感到兴奋", category: .feeling),
    NeedItem(image: "confused", text: "我感到困惑", category: .feeling),
    NeedItem(image: "sick", text: "我感到不舒服", category: .feeling)
]


package tt;

/**
 * 转化回传事件属性类
 * 基于字节跳动事件管理平台文档实现
 * https://event-manager.oceanengine.com/docs/8650/all_properties
 */
class ConversionProperty {
	// 商品相关属性

	/** 商品大图，多个图片url可用逗号分隔 */
	public static final PRODUCT_PIC_URL:String = "product_pic_url";

	/** 商品类目 */
	public static final PRODUCT_CATEGORY:String = "product_category";

	/** 商品价格 */
	public static final PRODUCT_PRICE:String = "product_price";

	/** 商品名称 */
	public static final PRODUCT_NAME:String = "product_name";

	/** 商品数量 */
	public static final SKU_COUNT:String = "sku_count";

	/** 商品单价，单位分 */
	public static final SKU_AMOUNT:String = "sku_amount";

	/** 团购商品id；引流电商中为用户下单商品ID */
	public static final SKU_ID:String = "sku_id";

	/** 商品id，内部或外部商品 */
	public static final PRODUCT_ID:String = "product_id";

	// 订单相关属性

	/** 商品订单ID，引流电商场景中用户在电商平台下单的订单ID */
	public static final ORDER_ID:String = "order_id";

	/** 下单金额，用户在电商平台APP内提交订单的金额，单位元 */
	public static final ORDER_AMOUNT:String = "order_amount";

	// 平台相关属性

	/** 是否是实验数据 */
	public static final IS_EXPERIMENT:String = "is_experiment";

	/** 来源平台，引流电商，用户下单所在的电商平台 */
	public static final ECOM_PLATFORM:String = "ecom_platform";

	/** 店铺名称，引流电商，用户下单所在的店铺名称 */
	public static final SHOP_NAME:String = "shop_name";

	/** 数据回传身份（代理商识别），引流电商，转化数据回传者身份 */
	public static final TEC_AGENT:String = "tec_agent";

	// 无效线索相关属性

	/** 无效类型，无效线索回传场景，客户回传命中的无效规则 */
	public static final REASON_CODE:String = "reason_code";

	/** 无效原因，自选无效原因，选填，当reason_code = OTHER的时候填写 */
	public static final REASON_MESSAGE:String = "reason_message";

	// 电话相关属性

	/** 电话接通时长，广告主获取线索后，主动拨打电话联络用户，电话接通后的通话时长，以秒为单位 */
	public static final PHONE_DIAL_DURATION:String = "phone_dial_duration";

	/** 电话拨打次数，广告主获取线索后，主动拨打电话联络用户的次数 */
	public static final PHONE_DIAL_NUM:String = "phone_dial_num";

	// 用户质量相关属性

	/** 分类类型，客户对用户价值判断分类，枚举值：1,2,3,4,5 */
	public static final CLASSIFICATION_TYPE:String = "classification_type";

	/** 差异价值人群质量（v2分档版），金融行业授信事件差异价值获取属性，支持1、2、3、4、5五档 */
	public static final PEOPLE_QUALITY_LEVEL:String = "people_quality_level";

	/** 差异价值人群质量，金融行业授信事件差异价值获取属性，枚举值：1(高质量),2(中质量),3(低质量) */
	public static final PEOPLE_QUALITY:String = "people_quality";

	/** 用户价值类型，premium_payment(保险支付)事件下的属性，表示付款用户的用户价值，枚举值：1(低净值),2(高净值) */
	public static final VALUE_TYPE:String = "value_type";

	/** M2退保率预估，广告主对保险用户的M2退保率的预估 */
	public static final M2_SURRENDER:String = "m2_surrender";

	/** M2质量分，自有建模预估能力的客户对保险用户M2后是否续保的打分 */
	public static final M2_SCORE:String = "m2_score";

	// 教育相关属性

	/** 正价课购买次数，教育行业深度转化，优化用户的正价课购买行为 */
	public static final CLASS_PURCHASE_AMOUNT:String = "class_purchase_amount";

	/** 用户转化的正价课价格，教育行业客户后链路转化正价课在客户侧的对应课程价格 */
	public static final ORIGIN_CLASS_PRICE:String = "origin_class_price";

	/** 用户转化的正价课id，教育行业客户后链路转化正价课在客户侧的对应课程id */
	public static final ORIGIN_CLASS_ID:String = "origin_class_id";

	/** 听课时长，标示这个转化事件发生时用户传了，单位分钟 */
	public static final LENGTH_OF_STUDY:String = "length_of_study";

	/** 是否交作业，标示这个转化事件发生时用户是否交当堂课作业，枚举值：0-未交作业，1-交了作业 */
	public static final HOMEWORK:String = "homework";

	/** 当前课程节数，标志这个转化事件对应的是教育客户低价课的哪一节 */
	public static final CLASS_NUM:String = "class_num";

	// 直播相关属性

	/** 主播id */
	public static final ANCHOR_ID:String = "anchor_id";

	/** 直播间来源二级目录 */
	public static final ENTER_METHOD:String = "enter_method";

	/** 直播间来源页面 */
	public static final ENTER_FROM_MERGE:String = "enter_from_merge";

	// 客服相关属性

	/** 智能客服服务方，枚举值：wechatim(腾讯微信智能客服),xiaoliuim(巨量引擎小六客服),douyinim(抖音私信) */
	public static final IM_SERVICE_TYPE:String = "im_service_type";

	/** 智能客服回复方式，枚举值：auto(系统自动回复),staff(人工客服回复) */
	public static final REPLY_MODE:String = "reply_mode";

	/** 智能客服是否发送欢迎语，枚举值：1(已发送),0(已调起客服页面但未触发欢迎语) */
	public static final IF_HELLO:String = "if_hello";

	/** 智能客服对话输入方式，枚举值：input(用户主动输入),pick(用户点击菜单输入) */
	public static final DIALOG_MODE:String = "dialog_mode";

	// 消耗相关属性

	/** 聚合页二跳详情，聚合页二跳各pos位置的详细数据，包括cost/ctr/cvr/ecpm等，包装在结构体中进行序列化 */
	public static final AGG_COST_DETAIL:String = "agg_cost_detail";

	/** lu广告主消耗明细，记录LU场景下广告主消耗的ctr/cvr/bid等 */
	public static final CONSUMPTION_DETAIL:String = "consumption_detail";

	/** 聚合页消耗金额总和，单位1e-5元 */
	public static final AGG_COST:String = "agg_cost";

	/** LU搜索侧广告主消耗金额，单位1e-5元 */
	public static final CONSUMPTION:String = "consumption";

	/** LU搜索侧广告主总消耗金额，单位1e-5元 */
	public static final CONSUMPTION2:String = "consumption2";

	// 其他属性

	/** 原始事件，客户自定义的原始事件 */
	public static final ORIGINAL_EVENTS:String = "original_events";

	// 教育行业相关属性（补充）

	/** 是否为末课，标示这个转化事件对应的是否为教育客户低价课的最后一节，0-不为末课，1-为末课 */
	public static final FINAL_CLASS:String = "final_class";

	/** 用户转化的年级，教育行业客户转化课程对应的年级 */
	public static final ORIGIN_CLASS_GRADE:String = "origin_class_grade";

	// 小说行业相关属性

	/** 用户上次在该频道活跃时间戳 */
	public static final NOVEL_AC_LAST_ACTIVE_TS:String = "novel_ac_last_active_ts";

	/** 小说频道类型，用户活跃频道的具体细分 */
	public static final NOVEL_AC_CATEGORY:String = "novel_ac_category";

	/** 小说频道性别类型，该频道为男频还是女频 */
	public static final NOVEL_AC_GENDER:String = "novel_ac_gender";

	/** 加入书架时间戳 */
	public static final NOVEL_BS_ADD_TS:String = "novel_bs_add_ts";

	/** 加入书架小说的作者 */
	public static final NOVEL_BS_AUTHOR:String = "novel_bs_author";

	/** 加入书架的小说类别 */
	public static final NOVEL_BS_CATEGORY:String = "novel_bs_category";

	/** 加入书架的小说名 */
	public static final NOVEL_BS_TITLE:String = "novel_bs_title";

	/** 上次阅读时间戳，用户上一次阅读该小说的时间戳 */
	public static final NOVEL_RC_LAST_READ_TS:String = "novel_rc_last_read_ts";

	/** 小说起始付费章节，用户阅读的小说起始付费章节（付费类小说） */
	public static final NOVEL_RC_PAYCHAPTER:String = "novel_rc_paychapter";

	/** 用户在该小说总阅读时长 */
	public static final NOVEL_RC_DURATION:String = "novel_rc_duration";

	/** 用户阅读到的小说章节 */
	public static final NOVEL_RC_CHAPTER:String = "novel_rc_chapter";

	/** 用户阅读的小说作者 */
	public static final NOVEL_RC_AUTHOR:String = "novel_rc_author";

	/** 用户阅读的小说的类别 */
	public static final NOVEL_RC_CATEGORY:String = "novel_rc_category";

	/** 用户阅读的小说名 */
	public static final NOVEL_RC_TITLE:String = "novel_rc_title";

	/** 小说数据行为类型，回传的是该用户的哪种行为信息 */
	public static final NOVEL_TYPE:String = "novel_type";

	// 金融行业相关属性

	/** 贷款价值，互金行业 */
	public static final LOAN_VALUE:String = "loan_value";

	/** 贷款场景，互金行业 */
	public static final FROM_CHANNEL:String = "from_channel";

	// 通用属性

	/** 付费金额，各行业可通用 */
	public static final PAY_AMOUNT:String = "pay_amount";

	/** 订单类型，旅游等行业 */
	public static final ORDER_TYPE:String = "order_type";

	/** 订单数量，旅游等行业；引流电商中代表购买件数 */
	public static final ORDER_CNT:String = "order_cnt";

	/** 激活质量，各行业通用 */
	public static final ACTIVE_LEVEL:String = "active_level";

	/** 阅读时长，小说行业 */
	public static final READING_TIME:String = "reading_time";

	/** 关键行为水平，关键行为水平（通用） */
	public static final KEY_LEVEL:String = "key_level";

	/** 支付方式，通用 */
	public static final PAY_TYPE:String = "pay_type";

	/** 用户价值，1-10整数值 */
	public static final USER_VALUE:String = "user_value";

	/** 用户性别 */
	public static final GENDER:String = "gender";

	// 游戏行业相关属性

	/** 状态，（游戏）当玩家完成游戏内主要系统和玩法的新手教学，且在游戏内不需要额外指引就能自主进行游戏时上报 */
	public static final IS_SUCCESS:String = "is_success";

	/** 角色id，（游戏） */
	public static final GAMEROLE_ID:String = "gamerole_id";

	/** 角色总数，（游戏）首次创建角色回传 1 */
	public static final GAMEROLE_SUM:String = "gamerole_sum";

	/** 当前等级，（游戏） */
	public static final LEVEL:String = "level";

	/** 等级价值（可选），（游戏）0=高价值；1=低价值 */
	public static final LEVEL_VALUE:String = "level_value";

	/** 升级标的，（游戏）0=主人物（最高维度的等级，例如玩家等级、账号等级，必传） */
	public static final ITEM_TYPE:String = "item_type";

	/** 升级目标 ID，（游戏）基于item_type 传的字段，传对应的主人物 ID、角色ID、宠物ID、装备ID */
	public static final ITEM_ID:String = "item_id";

	/** 关卡类型，（游戏）0=主线关卡，1=活动关卡，2=挑战关卡 */
	public static final SECTION_TYPE:String = "section_type";

	/** 主线关卡序号，（游戏）（限关卡类型为主线关卡情况下使用） */
	public static final MAIN_SECTION_NO:String = "main_section_no";

	/** 关卡价值（可选），（游戏）0=高价值；1=低价值 */
	public static final SECTION_VALUE:String = "section_value";

	/** 关卡名称，（游戏）关卡在游戏中对应的中文名 */
	public static final SECTION_NAME:String = "section_name";

	/** 关卡id，（游戏）int */
	public static final SECTION_ID:String = "section_id";

	/** 玩家已完成关卡总数，（游戏）int */
	public static final SECTION_SUM:String = "section_sum";

	/** 任务类型，（游戏）0=每日任务（为了活跃用户），1=主线任务（为了完成主线），2=活动任务（特定活动），3=其他 */
	public static final QUEST_TYPE:String = "quest_type";

	/** 任务价值（可选），（游戏）0=高价值；1=低价值 */
	public static final QUEST_VALUE:String = "quest_value";

	/** 任务id，（游戏）string */
	public static final QUEST_ID:String = "quest_id";

	/** 任务名称（可选），（游戏） */
	public static final QUEST_NAME:String = "quest_name";

	/** 本次游玩时长，（游戏）单位默认为秒 */
	public static final GAME_TIME:String = "game_time";

	/** 商店 ID，（游戏）活动商店，充值商店等 */
	public static final SHOP_ID:String = "shop_id";

	/** 抽卡/开箱次数，（游戏）int */
	public static final LOTTERY_TIME:String = "lottery_time";

	/** 玩家当前抽卡总次数，（游戏）int */
	public static final LOTTERY_SUM:String = "lottery_sum";

	/** 积分/货币类型（必选），（游戏）int */
	public static final TOKEN_TYPE:String = "token_type";

	/** 货币/积分ID，（游戏）string */
	public static final TOKEN_ID:String = "token_id";

	/** 道具名称，（游戏）string */
	public static final RESOURCE_NAME:String = "resource_name";

	/** 道具价值（可选），（游戏）int（枚举值） */
	public static final RESOURSE_VALUE:String = "resourse_value";

	/** 道具数量，（游戏）int */
	public static final RESOURSE_NUM:String = "resourse_num";

	/** 道具类型，（游戏）string（枚举值） */
	public static final RESOURCE_TYPE:String = "resource_type";

	/** 道具来源（可选），（游戏）int（枚举值） */
	public static final RESOURSE_SOURCE:String = "resourse_source";

	/** 竞争类型，（游戏）string（枚举值） */
	public static final COMPETE_TYPE:String = "compete_type";

	/** 胜利/失败，（游戏）string（枚举值） */
	public static final IS_SUCESS:String = "is_sucess";

	/** 玩家战斗得分（可选），（游戏）int */
	public static final SCORE:String = "score";

	/** 成就类型，（游戏）string（枚举值） */
	public static final ACHIEVEMENT_TYPE:String = "achievement_type";

	/** 总成就数，（游戏）int */
	public static final ACHIEVEMENT_SUM:String = "achievement_sum";

	/** 成就id，（游戏）string */
	public static final ACHIEVEMENT_ID:String = "achievement_id";

	/** 玩家当前总好友数，（游戏）int */
	public static final FRIEND_SUM:String = "friend_sum";

	/** 组织编号，（游戏）string */
	public static final UNION_ID:String = "union_id";

	/** 领土ID，（游戏）string */
	public static final GROUND_ID:String = "ground_id";
}

package tt;

/**
 * 转换事件类型
 */
class ConversionEventType {
	/** 电话拨打 - 用户点击拨打电话 */
	public static final PHONE:String = "phone";

	/** 表单提交 - 用户在页面内完成表单填写并提交 */
	public static final FORM:String = "form";

	/** 关键页面浏览 - 用户完成指定页面加载并到访 */
	public static final VIEW:String = "view";

	/** 激活 - 用户下载app完成激活行为 */
	public static final ACTIVE:String = "active";

	/** 注册 - 用户在推广的应用/落地页场景下完成注册（手机号/微信等）行为 */
	public static final ACTIVE_REGISTER:String = "active_register";

	/** 付费 - 用户在推广的应用/落地页场景下发生交易并完成至少一笔付款 */
	public static final ACTIVE_PAY:String = "active_pay";

	/** 智能电话-确认拨打 */
	public static final PHONE_CONFIRM:String = "phone_confirm";

	/** 智能电话-确认接通 */
	public static final PHONE_CONNECT:String = "phone_connect";

	/** 智能电话-有效接通 */
	public static final PHONE_EFFECTIVE:String = "phone_effective";

	/** 有效咨询 - 一般指用户点击"在线咨询"，通过IM向商户进行有效咨询，发言≥1条 */
	public static final CONSULT_EFFECTIVE:String = "consult_effective";

	/** app内下单 - 用户进入电商平台APP，并完成提交订单行为 */
	public static final IN_APP_ORDER:String = "in_app_order";

	/** app内访问 - 用户成功打开访问应用打开并访问通常考核吊起打开 */
	public static final IN_APP_UV:String = "in_app_uv";

	/** app内添加购物车 - 用户将商品加入购物车 */
	public static final IN_APP_CART:String = "in_app_cart";

	/** app内付费 - 用户完成商品下单并完成付款 */
	public static final IN_APP_PAY:String = "in_app_pay";

	/** 关键行为 - 用户在推广的应用/落地页场景下发生的关键行为/行为集合 */
	public static final GAME_ADDICTION:String = "game_addiction";

	/** 有效获客 - 提交线索的用户进一步完成了一次有价值的行为 */
	public static final CUSTOMER_EFFECTIVE:String = "customer_effective";

	/** 卡券领取 - 用户完成卡券领取行为 */
	public static final COUPON:String = "coupon";

	/** app内详情页到站uv - 浏览重点页面，比如商品页、活动页、文章等 */
	public static final IN_APP_DETAIL_UV:String = "in_app_detail_uv";

	/** 次留 - 激活且在第二天内打开app */
	public static final NEXT_DAY_OPEN:String = "next_day_open";

	/** 访问目标页面 - 用户完成指定目标页面加载并到访 */
	public static final PAGE_VIEW:String = "page_view";

	/** 商品购买 - 用户完成商品购买行为 */
	public static final SHOPPING:String = "shopping";

	/** 微信复制 - 用户完成个人或公众号微信复制行为，引导用户微信加粉 */
	public static final WECHAT:String = "wechat";

	/** 其他 */
	public static final OTHER:String = "other";

	/** 多转化 - 在橙子建站落地页中，当用户发生表单提交、智能电话-确认接通、留咨咨询、卡券领取中任意一个行为时都算一次"多转化"行为 */
	public static final MULTIPLE:String = "multiple";

	/** 完件 - 贷款完件 */
	public static final LOAN_COMPLETION:String = "loan_completion";

	/** 预授信 - 贷款预授信 */
	public static final PRE_LOAN_CREDIT:String = "pre_loan_credit";

	/** 授信 - 贷款授信 */
	public static final LOAN_CREDIT:String = "loan_credit";

	/** 身份证信息填写完成 */
	public static final IDCARD_INFORMATION:String = "idcard_information";

	/** 银行卡信息填写完成 */
	public static final BANKCARD_INFORMATION:String = "bankcard_information";

	/** 补充个人信息填写完成 */
	public static final PERSONAL_INFORMATION:String = "personal_information";

	/** 用户活体认证信息上传完成 */
	public static final CERTIFICATION_INFORMATION:String = "certification_information";

	/** 广告变现ROI */
	public static final LT_ROI:String = "lt_roi";

	/** 放款 - 贷款放款 */
	public static final LOAN:String = "loan";

	/** 授权 - 用户完成授权登录（微信/微博/淘宝等） */
	public static final AUTHORIZATION:String = "authorization";

	/** 留资咨询 - 用户在非抖音私信的咨询工具中成功留下电话/微信 */
	public static final CONSULT_CLUE:String = "consult_clue";

	/** 店铺停留 - 用户调起电商平台APP，并在指定页面停留15s */
	public static final STAY_TIME:String = "stay_time";

	/** 付费ROI - 用户付费金额/付费成本 */
	public static final PURCHASE_ROI:String = "purchase_roi";

	/** 预约下载 - 用户点击预约"游戏下载" */
	public static final NOTIFY_DOWNLOAD:String = "notify_download";

	/** 保险支付 - 用户完成购买保险行为 */
	public static final PREMIUM_PAYMENT:String = "premium_payment";

	/** ROI三目标 - ROI、次留率、激活成本 */
	public static final UG_ROI:String = "ug_roi";

	/** 微信内注册 - 用户在微信生态进入H5页面 */
	public static final IN_WECHAT_LOGIN:String = "in_wechat_login";

	/** 微信内付费 - 用户在微信生态完成付费 */
	public static final IN_WECHAT_PAY:String = "in_wechat_pay";

	/** 回访_信息确认 - 线索经联系确认是本人提交的信息，或者是本人有初步意向 */
	public static final CLUE_CONFIRM:String = "clue_confirm";

	/** 回访_加为好友 - 线索和销售建立了交流，比如互加好友，建立联系，可以持续跟进 */
	public static final CLUE_INTERFLOW:String = "clue_interflow";

	/** 回访_高潜成交 - 线索有较强意向成交或者处于成交流程，尚未完结 */
	public static final CLUE_HIGH_INTENTION:String = "clue_high_intention";

	/** 提交认证 - 用户完成认证资料提交（司机端） */
	public static final SUBMIT_CERTIFICATION:String = "submit_certification";

	/** 身份认证 - 用户完成平台身份认证（司机端） */
	public static final IDENTIFICATION:String = "identification";

	/** 首次完单（司机） - 用户完成首次接单任务（司机端） */
	public static final FIRST_ORDER:String = "first_order";

	/** 首次发单（乘客） - 用户首次发起在线叫车/租车（乘客端） */
	public static final FIRST_RENTAL_ORDER:String = "first_rental_order";

	/** 完成订单（乘客） - 用户完成在线叫车/租车订单（乘客端） */
	public static final RENTAL_ORDER_FINISH:String = "rental_order_finish";

	/** 支付_存在意向 - 在落地页完成的在线支付成功行为 */
	public static final CLUE_PAY_SUCCEED:String = "clue_pay_succeed";

	/** 14日留存 - 用户激活后在第14天仍有打开行为 */
	public static final RETENTION_14D:String = "retention_14d";

	/** 30日留存 - 用户激活应用后30天启动应用 */
	public static final RETENTION_30D:String = "retention_30d";

	/** 2日留存 - 用户激活应用后第2天启动应用 */
	public static final RETENTION_2D:String = "retention_2d";

	/** 3日留存 - 用户激活应用后第3天启动应用 */
	public static final RETENTION_3D:String = "retention_3d";

	/** 4日留存 - 用户激活应用后第4天启动应用 */
	public static final RETENTION_4D:String = "retention_4d";

	/** 5日留存 - 用户激活应用后第5天启动应用 */
	public static final RETENTION_5D:String = "retention_5d";

	/** 6日留存 - 用户激活应用后第6天启动应用 */
	public static final RETENTION_6D:String = "retention_6d";

	/** 7日留存 - 用户激活应用后第7天启动应用 */
	public static final RETENTION_7D:String = "retention_7d";

	/** 保费ROI - 用户获取一个保费支付用户所带来的ROI */
	public static final PREMIUM_ROI:String = "premium_ROI";

	/** ltv0 - LTV0-实际值，单位：分；整数，连续值 */
	public static final LTV0:String = "ltv0";

	/** 到店线索（汽车） - 线索客户产生到店行为 */
	public static final ARRIVAL_LEAD:String = "arrival_lead";

	/** 战败线索（汽车） - 有效线索客户跟进失败 */
	public static final FAILED_LEAD:String = "failed_lead";

	/** （体验课首课）到课 - 用户购买体验课后完成第一节到课行为 */
	public static final FIRST_CLASS:String = "first_class";

	/** （体验课末课）完课 - 用户购买体验课后上完最后一节课 */
	public static final FINISH_CLASS:String = "finish_class";

	/** 正价课购买 - 用户购买低价课后完成正价课购买 */
	public static final CONVERSION_CLASS:String = "conversion_class";

	/** 添加老师 - 教育用户低价课购买后，成功添加教育培训机构老师微信 */
	public static final ADD_TEACHER:String = "add_teacher";

	/** 拉活次留 - 沉默老用户进行app内访问后的次日留存 */
	public static final IN_APP_NEXT_DAY_OPEN:String = "in_app_next_day_open";

	/** 短期退保 - 用户完成首次保险支付短期内退保 */
	public static final WITHDRAW_INSURANCE:String = "withdraw_insurance";

	/** 开户 - 用户成功开通证券交易账户 */
	public static final OPEN_ACCOUNT:String = "open_account";

	/** 激活首日广告展示 - 用户激活首日发生一次广告展示 */
	public static final IMPRESSION:String = "impression";

	/** 首日广告展示达标 - 用户激活首日广告展示次数达到预期 */
	public static final IPU_QUALIFY:String = "ipu_qualify";

	/** LU页面二跳点击 - 用户在搜索结果页发生点击 */
	public static final LU_CLICK:String = "lu_click";

	/** LU页面二跳转化 - 用户在搜索结果页上发生转化 */
	public static final LU_CONVERT:String = "lu_convert";

	/** M2内退保 - 用户完成首次保险支付60天内退保 */
	public static final WITHDRAW_M2:String = "withdraw_m2";

	/** 次级授信 - 信贷客户为判定为次级的用户完成授信 */
	public static final LOW_LOAN_CREDIT:String = "low_loan_credit";

	/** 高价值授信 - 信贷客户为判定为高价值的用户完成授信 */
	public static final HIGH_LOAN_CREDIT:String = "high_loan_credit";

	/** 微信取关 - 加微信成功后T日取消关注 */
	public static final UNFOLLOW_IN_WECHAT:String = "unfollow_in_wechat";

	/** 线索-购买方案详谈 - 线索类-电销回访类业务-成单前详细沟通购买方案环节 */
	public static final CLUE_DETAIL_PLAN:String = "clue_detail_plan";

	/** 线索-正式成单 - 线索类-电销回访类业务-实际高客单价成单 */
	public static final CLUE_FORMAL_ORDER:String = "clue_formal_order";

	/** LU页面二跳show - 搜索结果页广告show */
	public static final LU_SHOW:String = "lu_show";

	/** app内7日下单 - 用户进入电商平台APP，在7日内提交订单行为 */
	public static final IN_APP_ORDER_7D:String = "in_app_order_7d";

	/** 关键行为衍生事件一 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION1:String = "key_action1";

	/** 关键行为衍生事件二 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION2:String = "key_action2";

	/** 关键行为衍生事件三 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION3:String = "key_action3";

	/** 关键行为衍生事件四 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION4:String = "key_action4";

	/** 关键行为衍生事件五 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION5:String = "key_action5";

	/** 关键行为衍生事件六 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION6:String = "key_action6";

	/** 关键行为衍生事件七 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION7:String = "key_action7";

	/** 关键行为衍生事件八 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION8:String = "key_action8";

	/** 关键行为衍生事件九 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION9:String = "key_action9";

	/** 关键行为衍生事件十 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION10:String = "key_action10";

	/** 关键行为衍生事件十一 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION11:String = "key_action11";

	/** 关键行为衍生事件十二 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION12:String = "key_action12";

	/** 关键行为衍生事件十三 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION13:String = "key_action13";

	/** 关键行为衍生事件十四 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION14:String = "key_action14";

	/** 关键行为衍生事件十五 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION15:String = "key_action15";

	/** 关键行为衍生事件十六 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION16:String = "key_action16";

	/** 关键行为衍生事件十七 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION17:String = "key_action17";

	/** 关键行为衍生事件十八 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION18:String = "key_action18";

	/** 关键行为衍生事件十九 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION19:String = "key_action19";

	/** 关键行为衍生事件二十 - 投放关键行为过程中的衍生事件 */
	public static final KEY_ACTION20:String = "key_action20";

	/** 线索_续费成单 - 线索正式成单后，续费/续约/再次成单 */
	public static final CLUE_ORDER_AGAIN:String = "clue_order_again";

	/** 付费ROI-2日 - 用户2日内付费金额/付费成本 */
	public static final PURCHASE_ROI_2D:String = "purchase_roi_2d";

	/** 付费ROI-7日 - 用户7日内付费金额/付费成本 */
	public static final PURCHASE_ROI_7D:String = "purchase_roi_7d";

	/** 拉活30日留存 - 用户通过调起广告启动应用后第30天再次启动应用 */
	public static final IN_APP_RETENTION_30D:String = "in_app_retention_30d";

	/** 拉活28日留存 - 用户通过调起广告启动应用后第28天再次启动应用 */
	public static final IN_APP_RETENTION_28D:String = "in_app_retention_28d";

	/** 拉活14日留存 - 用户通过调起广告启动应用后第14天再次启动应用 */
	public static final IN_APP_RETENTION_14D:String = "in_app_retention_14d";

	/** 拉活7日留存 - 用户通过调起广告启动应用后第7天再次启动应用 */
	public static final IN_APP_RETENTION_7D:String = "in_app_retention_7d";

	/** 拉活6日留存 - 用户通过调起广告启动应用后第6天再次启动应用 */
	public static final IN_APP_RETENTION_6D:String = "in_app_retention_6d";

	/** 拉活5日留存 - 用户通过调起广告启动应用后第5天再次启动应用 */
	public static final IN_APP_RETENTION_5D:String = "in_app_retention_5d";

	/** 拉活4日留存 - 用户通过调起广告启动应用后第4天再次启动应用 */
	public static final IN_APP_RETENTION_4D:String = "in_app_retention_4d";

	/** 拉活3日留存 - 用户通过调起广告启动应用后第3天再次启动应用 */
	public static final IN_APP_RETENTION_3D:String = "in_app_retention_3d";

	/** 拉活2日留存 - 用户通过调起广告启动应用后第2天再次启动应用 */
	public static final IN_APP_RETENTION_2D:String = "in_app_retention_2d";

	/** 退款数据流 - 用户申请订单退款 */
	public static final ORDER_REFUND:String = "order_refund";

	/** 保险升级 - 金融保险用户支付后升级更高保额 */
	public static final PREMIUM_UPGRADE:String = "premium_upgrade";

	/** arpu门槛 - 是否满足首日变现价值=X */
	public static final ARPU0:String = "arpu0";

	/** 按钮点击 - 电商店铺推广目的，调起按钮点击 */
	public static final BUTTON_CLICK:String = "button_click";

	/** 微信_二维码展示 - 进入客户小程序后，完成企业微信的二维码展示 */
	public static final WECHAT_QRCODE_SHOW:String = "wechat_qrcode_show";

	/** 微信_长按二维码 - 进入客户小程序后，长按识别企业微信二维码 */
	public static final WECHAT_QRCODE_TRY:String = "wechat_qrcode_try";

	/** 微信_添加企业微信 - 用户扫描二维码，成功添加商家的企业微信 */
	public static final WORK_WECHAT_ADDED:String = "work_wechat_added";

	/** 微信_用户首次消息 - 用户添加企业微信后，首次发起消息，开口咨询 */
	public static final WORK_WECHAT_DIALOG:String = "work_wechat_dialog";

	/** 微信_用户确认意向 - 添加企业微信后，用户表明确定有需求意向 */
	public static final WORK_WECHAT_CONFIRM:String = "work_wechat_confirm";

	/** 首购 - 用户在平台发生的首次购买行为 */
	public static final FIRST_PAY:String = "first_pay";

	/** 付费-新 - 新用户在推广场景下完成的每一笔付款 */
	public static final SUPPLY_ACTIVE_PAY:String = "supply_active_pay";

	/** 留存天数 - 激活后7日内的留存行为 */
	public static final RETENTION_DAYS:String = "retention_days";

	/** 评论区链接激活 - 用户通过点击视频评论区置顶链接下载激活 */
	public static final LINK_ACTIVE:String = "link_active";

	/** 小程序广告变现ltv - 用户在小游戏内单次广告请求产生的收入 */
	public static final MICRO_GAME_LTV:String = "micro_game_ltv";

	/** 企业微信_取消好友 - 用户取消和广告客户员工企业微信的好友关系 */
	public static final WORK_WECHAT_UNFRIEND:String = "work_wechat_unfriend";

	/** 智能客服_系统回复 - 系统发送回复消息成功 */
	public static final IM_REPLY:String = "im_reply";

	/** 智能客服_用户开口 - 用户主动任意回复消息 */
	public static final IM_DIALOG:String = "im_dialog";

	/** 智能客服_唤起 - 用户通过点击链接进入微信客服会话 */
	public static final IM_AROUSE:String = "im_arouse";

	/** 是否风险用户 - 标记广告主口径判断的风险用户 */
	public static final IS_RISK_USER:String = "is_risk_user";

	/** 是否低质用户 - 标记是否后端转化/回收较差的用户 */
	public static final IS_LOW_QUALITY_USER:String = "is_low_quality_user";

	/** 抖音自然捐赠确认 - 抖音绿色通过回传捐赠事件 */
	public static final GROOT_HABITAT_DONATE_CONFIRM:String = "groot_habitat_donate_confirm";

	/** 激活-新 - 用户下载app完成激活行为 */
	public static final SUPPLY_ACTIVE:String = "supply_active";

	/** 认证支付 - 在企业关键信息填写完成后，用户完成认证费用支付 */
	public static final CERTIFIED_PAY:String = "certified_pay";

	/** 信息验真 - 用户完成对公打款信息确认或人脸识别等 */
	public static final INFORMATION_CHECK:String = "information_check";

	/** 口令获客 - 复制口令，打开抖音进入落地页产生入驻动作 */
	public static final PASSWORD_ACQUISITION:String = "password_acquisition";

	/** 发送口令 - 点击复制口令发送给微信好友 */
	public static final PASSWORD_SEND:String = "password_send";

	/** 支付成功 - 拉起支付后，成功完成订单支付 */
	public static final SUCCESSFUL_PAY:String = "successful_pay";

	/** 支付意向 - 用户点击关键按钮，完成一次有价值的行为 */
	public static final INTENTION_PAY:String = "intention_pay";

	/** 支付行动 - 用户进入信息填写界面，提交支付意愿 */
	public static final ACTION_PAY:String = "action_pay";

	/** 微信_删除好友 - 成功添加用户微信后被删除好友 */
	public static final WECHAT_DELETE:String = "wechat_delete";

	/** 穿山甲聚合页消耗 - 穿山甲聚合页上产生的消耗总和 */
	public static final CSJ_AGG_LP:String = "csj_agg_lp";

	/** groot开始游戏 - groot海洋日游戏 */
	public static final GROOT_OCEAN_GAME_VIEW:String = "groot_ocean_game_view";

	/** 开始抽奖 - groot海洋日游戏 */
	public static final GROOT_OCEAN_GAME_LOTTERY_CLICK:String = "groot_ocean_game_lottery_click";

	/** 负向样本 - 星链-负向样本 */
	public static final NEGATIVE:String = "negative";

	/** 目标待优化 - 星链-目标待优化 */
	public static final PENDING:String = "pending";

	/** 6小时内全部退款 - 六小时内完全退款 */
	public static final FULL_REFUND_WITHIN_6H:String = "full_refund_within_6h";

	/** 通信存量业务退订 - 通信存量业务的退订数据 */
	public static final WITHDRAW:String = "withdraw";

	/** 直播间广告捐赠 - 用户在直播间用公益组件完成捐赠行为 */
	public static final AD_LIVE_DONATE:String = "ad_live_donate";

	/** 电话接通 - 广告主获取线索后，主动拨打电话联络用户 */
	public static final PHONE_LAB_1:String = "phone_lab_1";

	/** 线索拨打 - 广告主获取线索后，主动拨打电话联系客户 */
	public static final PHONE_DIAL:String = "phone_dial";

	/** 实际到店/到校 - 用户实际产生线下到店或到校行为 */
	public static final STORE_ARRIVAL:String = "store_arrival";

	/** 预约到店/到校 - 用户预约到店或预约到校行为 */
	public static final STORE_APPOINTMENT:String = "store_appointment";

	/** 体验课第X节到课 - 用户购买体验课后，完成除首节和末节的到课行为 */
	public static final X_CLASS:String = "x_class";

	/** 进群 - 微信群营销时，用户进入群聊 */
	public static final GROUP_CHAT:String = "group_chat";

	/** 微信回复大于3条 - 广告主与用户在微信内沟通，用户回复大于3条 */
	public static final WECHAT_REPLY3:String = "wechat_reply3";

	/** 电话未接通 - 广告主获取线索后拨打电话未接通 */
	public static final PHONE_FAIL:String = "phone_fail";

	/** 信贷ROI - 贷款授信场景下判断用户价值ROI分档 */
	public static final LOAN_CREDIT_ROI:String = "loan_credit_roi";

	/** 付费（完整） - 新用户在推广场景下完成的每一笔付款 */
	public static final ACTIVE_PAY_ALL:String = "active_pay_all";

	/** 付费金额（完整） - 新用户在推广场景下完成的每一笔付费金额 */
	public static final DEEP_PURCHASE_ALL:String = "deep_purchase_all";

	/** 引流收藏加购 - 用户进入电商平台APP，完成收藏或加购行为 */
	public static final COLLECTION_AND_WISHLIST:String = "collection_and_wishlist";

	/** 登录成功 - 登录成功/游戏行业：玩家每次完成账号登录 */
	public static final LOGIN:String = "login";

	/** 完成新手引导 - 完成新手教程/游戏：玩家完成所有核心功能的新手引导 */
	public static final COMPLETE_TUTORIAL:String = "complete_tutorial";

	/** 创建角色 - 创建角色/游戏：玩家创建角色时上传 */
	public static final CREATE_GAMEROLE:String = "create_gamerole";

	/** 等级升级 - 升级/游戏：每升1级回传一次 */
	public static final UPDATE_LEVEL:String = "update_level";

	/** 完成关卡 - 必传主线关卡和序号，标记特定关卡为高价值关卡 */
	public static final COMPLETE_SECTION:String = "complete_section";

	/** 完成任务 - 按照特定的任务类型时进行上报，用户每完成一个任务则上报一次 */
	public static final QUEST:String = "quest";

	/** 游戏时长 - 玩家结束（离线）游戏后上报，建议使用服务器端统计数据作为上报依据 */
	public static final TIME_SPENT:String = "time_spent";

	/** 游戏启动 - 打开app/游戏：游戏每次启动时上报 */
	public static final LAUNCH_APP:String = "launch_app";

	/** 打开商店 - 打开游戏内商店页面，包括充值选项页面 */
	public static final OPEN_SHOP:String = "open_shop";

	/** 抽卡/开箱 - 玩家每次抽卡时回传 */
	public static final DRAW_LOTTERY:String = "draw_lottery";

	/** 获取货币 - 玩家在游戏内获得游戏中的货币时上报，每次发生事件做上报 */
	public static final GAIN_TOKEN:String = "gain_token";

	/** 消费货币 - 玩家在游戏内消费游戏中的货币时上报，每次发生事件做上报 */
	public static final CONSUME_TOKEN:String = "consume_token";

	/** 参与竞争 - 玩家在游戏内参与PVP、PVE等竞争玩法或活动 */
	public static final COMPETE:String = "compete";

	/** 达成成就 - 玩家在游戏内达成特定的成就时，上报事件 */
	public static final ACHIEVE_SUCCESS:String = "achieve_success";

	/** 获取道具 - 玩家在游戏中获得重要的5种道具、资源时上报 */
	public static final GAIN_RESOURCE:String = "gain_resource";

	/** 添加好友 - 玩家每次添加好友时回传 */
	public static final ADD_FRIEND:String = "add_friend";

	/** 创建工会/组织/帮派/团体 - 玩家每次创建游戏内的工会/组织/帮派/团体 */
	public static final CREATE_UNION:String = "create_union";

	/** 加入工会/组织/帮派/团体 - 玩家每次加入游戏内工会/组织/帮派/团体 */
	public static final JOIN_UNION:String = "join_union";

	/** 占领领土 - SLG游戏事件，在玩家每次占领敌方领土时回传 */
	public static final OCCUPY_TERRITORY:String = "occupy_territory";

	/** 使用道具 - 在游戏中使用重要的5种道具、资源时上报，选取道具、资源需与"获取道具"上报类型一致 */
	public static final CONSUME_RESOURCE:String = "consume_resource";
}

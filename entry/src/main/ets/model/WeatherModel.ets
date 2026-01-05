// ==================== 天气数据模型 ====================

// 城市信息接口
export interface CityInfo {
  name: string;           // 城市名称
  code: string;           // 城市代码
  province: string;       // 所属省份
}

// 当前天气信息接口
export interface CurrentWeather {
  city: string;           // 城市名
  temperature: string;    // 当前温度
  weather: string;        // 天气状况（晴、多云等）
  humidity: string;       // 湿度
  windDirection: string;  // 风向
  windPower: string;      // 风力
  updateTime: string;     // 更新时间
  highTemp: string;       // 最高温度
  lowTemp: string;        // 最低温度
  airQuality: string;     // 空气质量
  airQualityIndex: string; // 空气质量指数
}

// 未来天气预报接口
export interface ForecastWeather {
  date: string;           // 日期
  week: string;           // 星期
  dayWeather: string;     // 白天天气
  nightWeather: string;   // 夜间天气
  highTemp: string;       // 最高温度
  lowTemp: string;        // 最低温度
  windDirection: string;  // 风向
  windPower: string;      // 风力
}

// 生活指数接口
export interface LifeIndex {
  name: string;           // 指数名称
  level: string;          // 等级
  desc: string;           // 建议描述
  icon: string;           // 图标
}

// 完整天气数据接口
export interface WeatherData {
  current: CurrentWeather;           // 当前天气
  forecast: ForecastWeather[];       // 未来预报
  lifeIndex: LifeIndex[];            // 生活指数
}

// 城市列表（包含城市代码，用于API查询）
export const CityList: CityInfo[] = [
  // 直辖市
  { name: '北京', code: '110000', province: '北京市' },
  { name: '上海', code: '310000', province: '上海市' },
  { name: '天津', code: '120000', province: '天津市' },
  { name: '重庆', code: '500000', province: '重庆市' },
  // 省会城市
  { name: '广州', code: '440100', province: '广东省' },
  { name: '深圳', code: '440300', province: '广东省' },
  { name: '杭州', code: '330100', province: '浙江省' },
  { name: '南京', code: '320100', province: '江苏省' },
  { name: '苏州', code: '320500', province: '江苏省' },
  { name: '武汉', code: '420100', province: '湖北省' },
  { name: '成都', code: '510100', province: '四川省' },
  { name: '西安', code: '610100', province: '陕西省' },
  { name: '长沙', code: '430100', province: '湖南省' },
  { name: '郑州', code: '410100', province: '河南省' },
  { name: '济南', code: '370100', province: '山东省' },
  { name: '青岛', code: '370200', province: '山东省' },
  { name: '大连', code: '210200', province: '辽宁省' },
  { name: '沈阳', code: '210100', province: '辽宁省' },
  { name: '哈尔滨', code: '230100', province: '黑龙江省' },
  { name: '长春', code: '220100', province: '吉林省' },
  { name: '福州', code: '350100', province: '福建省' },
  { name: '厦门', code: '350200', province: '福建省' },
  { name: '合肥', code: '340100', province: '安徽省' },
  { name: '南昌', code: '360100', province: '江西省' },
  { name: '昆明', code: '530100', province: '云南省' },
  { name: '贵阳', code: '520100', province: '贵州省' },
  { name: '南宁', code: '450100', province: '广西' },
  { name: '海口', code: '460100', province: '海南省' },
  { name: '三亚', code: '460200', province: '海南省' },
  { name: '兰州', code: '620100', province: '甘肃省' },
  { name: '西宁', code: '630100', province: '青海省' },
  { name: '银川', code: '640100', province: '宁夏' },
  { name: '乌鲁木齐', code: '650100', province: '新疆' },
  { name: '拉萨', code: '540100', province: '西藏' },
  { name: '呼和浩特', code: '150100', province: '内蒙古' },
  { name: '太原', code: '140100', province: '山西省' },
  { name: '石家庄', code: '130100', province: '河北省' }
];
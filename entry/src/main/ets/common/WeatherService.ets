// 导入数据模型
import {
  CityInfo,
  CurrentWeather,
  ForecastWeather,
  LifeIndex,
  WeatherData,
  CityList
} from '../model/WeatherModel';

//========== 城市天气配置接口==========
interface CityWeatherConfig {
  temp: string;
  highTemp: string;
  lowTemp: string;
  weather: string;
  humidity: string;
  windDir: string;
  windPower: string;
  airQuality: string;
  aqi: string;
  baseTemp: string;
}

//========== 天气服务类==========
export class WeatherService {

  // 获取天气数据（主方法）
  static async getWeatherData(cityName: string): Promise<WeatherData> {
    return new Promise((resolve: (value: WeatherData) => void, reject: (reason?: Object) => void) => {
      // 模拟网络延迟
      setTimeout(() => {
        try {
          const data = WeatherService.generateWeatherData(cityName);
          resolve(data);
        } catch (error) {
          reject(error as Object);
        }
      }, 800);
    });
  }

  // 生成天气数据
  private static generateWeatherData(cityName: string): WeatherData {
    const cityWeatherConfig = WeatherService.getCityWeatherConfig(cityName);

    // 当前天气
    const current: CurrentWeather = {
      city: cityName,
      temperature: cityWeatherConfig.temp,
      weather: cityWeatherConfig.weather,
      humidity: cityWeatherConfig.humidity,
      windDirection: cityWeatherConfig.windDir,
      windPower: cityWeatherConfig.windPower,
      updateTime: WeatherService.getCurrentTime(),
      highTemp: cityWeatherConfig.highTemp,
      lowTemp: cityWeatherConfig.lowTemp,
      airQuality: cityWeatherConfig.airQuality,
      airQualityIndex: cityWeatherConfig.aqi
    };

    // 未来7天预报
    const forecast: ForecastWeather[] = WeatherService.generateForecast(cityWeatherConfig);

    // 生活指数
    const lifeIndex: LifeIndex[] = WeatherService.generateLifeIndex(cityWeatherConfig);

    const result: WeatherData = {
      current: current,
      forecast: forecast,
      lifeIndex: lifeIndex
    };

    return result;
  }

  // 城市天气配置
  private static getCityWeatherConfig(cityName: string): CityWeatherConfig {
    // 默认配置
    const defaultConfig: CityWeatherConfig = {
      temp: '22',
      highTemp: '26',
      lowTemp: '18',
      weather: '晴',
      humidity: '50',
      windDir: '微风',
      windPower: '2级',
      airQuality: '良',
      aqi: '60',
      baseTemp: '22'
    };

    // 根据城市返回不同配置
    if (cityName === '北京') {
      const config: CityWeatherConfig = {
        temp: '18',
        highTemp: '23',
        lowTemp: '12',
        weather: '晴',
        humidity: '35',
        windDir: '北风',
        windPower: '3级',
        airQuality: '良',
        aqi: '75',
        baseTemp: '18'
      };
      return config;
    }

    if (cityName === '上海') {
      const config: CityWeatherConfig = {
        temp: '24',
        highTemp: '28',
        lowTemp: '20',
        weather: '多云',
        humidity: '68',
        windDir: '东南风',
        windPower: '2级',
        airQuality: '优',
        aqi: '45',
        baseTemp: '24'
      };
      return config;
    }

    if (cityName === '广州') {
      const config: CityWeatherConfig = {
        temp: '29',
        highTemp: '33',
        lowTemp: '25',
        weather: '阵雨',
        humidity: '82',
        windDir: '南风',
        windPower: '2级',
        airQuality: '良',
        aqi: '68',
        baseTemp: '29'
      };
      return config;
    }

    if (cityName === '深圳') {
      const config: CityWeatherConfig = {
        temp: '28',
        highTemp: '32',
        lowTemp: '24',
        weather: '多云',
        humidity: '78',
        windDir: '西南风',
        windPower: '3级',
        airQuality: '优',
        aqi: '42',
        baseTemp: '28'
      };
      return config;
    }

    if (cityName === '杭州') {
      const config: CityWeatherConfig = {
        temp: '22',
        highTemp: '26',
        lowTemp: '18',
        weather: '晴',
        humidity: '55',
        windDir: '东风',
        windPower: '1级',
        airQuality: '优',
        aqi: '38',
        baseTemp: '22'
      };
      return config;
    }

    if (cityName === '成都') {
      const config: CityWeatherConfig = {
        temp: '20',
        highTemp: '24',
        lowTemp: '16',
        weather: '阴',
        humidity: '72',
        windDir: '微风',
        windPower: '1级',
        airQuality: '轻度污染',
        aqi: '108',
        baseTemp: '20'
      };
      return config;
    }

    if (cityName === '武汉') {
      const config: CityWeatherConfig = {
        temp: '26',
        highTemp: '30',
        lowTemp: '22',
        weather: '多云',
        humidity: '65',
        windDir: '南风',
        windPower: '2级',
        airQuality: '良',
        aqi: '72',
        baseTemp: '26'
      };
      return config;
    }

    if (cityName === '西安') {
      const config: CityWeatherConfig = {
        temp: '21',
        highTemp: '26',
        lowTemp: '14',
        weather: '晴',
        humidity: '42',
        windDir: '西北风',
        windPower: '2级',
        airQuality: '良',
        aqi: '85',
        baseTemp: '21'
      };
      return config;
    }

    if (cityName === '南京') {
      const config: CityWeatherConfig = {
        temp: '23',
        highTemp: '27',
        lowTemp: '19',
        weather: '多云',
        humidity: '60',
        windDir: '东南风',
        windPower: '2级',
        airQuality: '优',
        aqi: '48',
        baseTemp: '23'
      };
      return config;
    }

    if (cityName === '重庆') {
      const config: CityWeatherConfig = {
        temp: '25',
        highTemp: '29',
        lowTemp: '21',
        weather: '阴',
        humidity: '75',
        windDir: '微风',
        windPower: '1级',
        airQuality: '良',
        aqi: '88',
        baseTemp: '25'
      };
      return config;
    }

    if (cityName === '天津') {
      const config: CityWeatherConfig = {
        temp: '17',
        highTemp: '22',
        lowTemp: '11',
        weather: '晴',
        humidity: '40',
        windDir: '北风',
        windPower: '3级',
        airQuality: '良',
        aqi: '82',
        baseTemp: '17'
      };
      return config;
    }

    if (cityName === '苏州') {
      const config: CityWeatherConfig = {
        temp: '23',
        highTemp: '27',
        lowTemp: '19',
        weather: '晴',
        humidity: '58',
        windDir: '东风',
        windPower: '2级',
        airQuality: '优',
        aqi: '35',
        baseTemp: '23'
      };
      return config;
    }

    if (cityName === '长沙') {
      const config: CityWeatherConfig = {
        temp: '27',
        highTemp: '31',
        lowTemp: '23',
        weather: '多云',
        humidity: '70',
        windDir: '南风',
        windPower: '2级',
        airQuality: '良',
        aqi: '65',
        baseTemp: '27'
      };
      return config;
    }

    if (cityName === '厦门') {
      const config: CityWeatherConfig = {
        temp: '26',
        highTemp: '30',
        lowTemp: '22',
        weather: '晴',
        humidity: '75',
        windDir: '东南风',
        windPower: '3级',
        airQuality: '优',
        aqi: '25',
        baseTemp: '26'
      };
      return config;
    }

    if (cityName === '海口') {
      const config: CityWeatherConfig = {
        temp: '32',
        highTemp: '35',
        lowTemp: '28',
        weather: '雷阵雨',
        humidity: '85',
        windDir: '东南风',
        windPower: '3级',
        airQuality: '优',
        aqi: '22',
        baseTemp: '32'
      };
      return config;
    }

    if (cityName === '三亚') {
      const config: CityWeatherConfig = {
        temp: '33',
        highTemp: '36',
        lowTemp: '27',
        weather: '晴',
        humidity: '80',
        windDir: '南风',
        windPower: '3级',
        airQuality: '优',
        aqi: '18',
        baseTemp: '33'
      };
      return config;
    }

    if (cityName === '哈尔滨') {
      const config: CityWeatherConfig = {
        temp: '10',
        highTemp: '15',
        lowTemp: '4',
        weather: '多云',
        humidity: '55',
        windDir: '西北风',
        windPower: '3级',
        airQuality: '良',
        aqi: '72',
        baseTemp: '10'
      };
      return config;
    }

    if (cityName === '沈阳') {
      const config: CityWeatherConfig = {
        temp: '14',
        highTemp: '19',
        lowTemp: '8',
        weather: '晴',
        humidity: '45',
        windDir: '西北风',
        windPower: '3级',
        airQuality: '良',
        aqi: '68',
        baseTemp: '14'
      };
      return config;
    }

    if (cityName === '大连') {
      const config: CityWeatherConfig = {
        temp: '16',
        highTemp: '20',
        lowTemp: '12',
        weather: '晴',
        humidity: '65',
        windDir: '南风',
        windPower: '3级',
        airQuality: '优',
        aqi: '28',
        baseTemp: '16'
      };
      return config;
    }

    if (cityName === '青岛') {
      const config: CityWeatherConfig = {
        temp: '18',
        highTemp: '22',
        lowTemp: '14',
        weather: '多云',
        humidity: '72',
        windDir: '东南风',
        windPower: '4级',
        airQuality: '优',
        aqi: '32',
        baseTemp: '18'
      };
      return config;
    }

    if (cityName === '昆明') {
      const config: CityWeatherConfig = {
        temp: '20',
        highTemp: '24',
        lowTemp: '14',
        weather: '多云',
        humidity: '65',
        windDir: '西南风',
        windPower: '2级',
        airQuality: '优',
        aqi: '35',
        baseTemp: '20'
      };
      return config;
    }

    if (cityName === '拉萨') {
      const config: CityWeatherConfig = {
        temp: '15',
        highTemp: '22',
        lowTemp: '6',
        weather: '晴',
        humidity: '25',
        windDir: '西风',
        windPower: '2级',
        airQuality: '优',
        aqi: '15',
        baseTemp: '15'
      };
      return config;
    }

    if (cityName === '乌鲁木齐') {
      const config: CityWeatherConfig = {
        temp: '12',
        highTemp: '18',
        lowTemp: '5',
        weather: '晴',
        humidity: '35',
        windDir: '西北风',
        windPower: '3级',
        airQuality: '良',
        aqi: '65',
        baseTemp: '12'
      };
      return config;
    }

    return defaultConfig;
  }

  // 生成未来7天预报
  private static generateForecast(config: CityWeatherConfig): ForecastWeather[] {
    const forecasts: ForecastWeather[] = [];
    const weathers: string[] = ['晴', '多云', '阴', '小雨', '阵雨', '晴转多云', '多云转晴'];
    const weeks: string[] = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    const baseTemp: number = parseInt(config.baseTemp) || 22;

    const today = new Date();

    for (let i = 0; i < 7; i++) {
      const date = new Date(today);
      date.setDate(today.getDate() + i);

      // 温度随机波动
      const tempOffset: number = Math.floor(Math.random() * 6) - 2;
      const high: number = baseTemp + 4 + tempOffset;
      const low: number = baseTemp - 4 + tempOffset;

      // 确定星期显示
      let weekText: string;
      if (i === 0) {
        weekText = '今天';
      } else if (i === 1) {
        weekText = '明天';
      } else {
        weekText = weeks[date.getDay()];
      }

      const forecast: ForecastWeather = {
        date: `${date.getMonth() + 1}/${date.getDate()}`,
        week: weekText,
        dayWeather: weathers[Math.floor(Math.random() * weathers.length)],
        nightWeather: weathers[Math.floor(Math.random() * weathers.length)],
        highTemp: high.toString(),
        lowTemp: low.toString(),
        windDirection: config.windDir,
        windPower: config.windPower
      };

      forecasts.push(forecast);
    }

    return forecasts;
  }

  // 生成生活指数
  private static generateLifeIndex(config: CityWeatherConfig): LifeIndex[] {
    const temp: number = parseInt(config.temp) || 22;
    const humidity: number = parseInt(config.humidity) || 50;
    const weather: string = config.weather;
    const lifeIndexList: LifeIndex[] = [];

    // 穿衣指数
    let dressLevel: string = '舒适';
    let dressDesc: string = '建议穿长袖衬衫或薄外套';

    if (temp >= 30) {
      dressLevel = '炎热';
      dressDesc = '建议穿短袖、短裤等清凉夏装';
    } else if (temp >= 25) {
      dressLevel = '热';
      dressDesc = '建议穿薄款短袖或T恤';
    } else if (temp >= 20) {
      dressLevel = '舒适';
      dressDesc = '建议穿长袖衬衫或薄外套';
    } else if (temp >= 15) {
      dressLevel = '较凉';
      dressDesc = '建议穿夹克或薄款毛衣';
    } else if (temp >= 10) {
      dressLevel = '凉';
      dressDesc = '建议穿风衣或厚外套';
    } else {
      dressLevel = '寒冷';
      dressDesc = '建议穿棉衣或羽绒服';
    }

    const dressIndex: LifeIndex = {
      name: '穿衣指数',
      level: dressLevel,
      desc: dressDesc,
      icon: '👔'
    };
    lifeIndexList.push(dressIndex);

    // 紫外线指数
    let uvLevel: string = '弱';
    let uvDesc: string = '无需特别防护';

    if (weather.includes('晴')) {
      uvLevel = '强';
      uvDesc = '涂抹SPF30+防晒霜，戴太阳镜';
    } else if (weather.includes('多云')) {
      uvLevel = '中等';
      uvDesc = '涂抹SPF15+防晒霜';
    }

    const uvIndex: LifeIndex = {
      name: '紫外线',
      level: uvLevel,
      desc: uvDesc,
      icon: '☀️'
    };
    lifeIndexList.push(uvIndex);

    // 运动指数
    let sportLevel: string = '适宜';
    let sportDesc: string = '天气适合户外运动';

    if (weather.includes('雨') || weather.includes('雪')) {
      sportLevel = '较不宜';
      sportDesc = '天气不佳，建议室内运动';
    } else if (temp >= 35 || temp < 5) {
      sportLevel = '较不宜';
      sportDesc = '温度不适，减少户外运动';
    }

    const sportIndex: LifeIndex = {
      name: '运动指数',
      level: sportLevel,
      desc: sportDesc,
      icon: '🏃'
    };
    lifeIndexList.push(sportIndex);

    // 洗车指数
    let carWashLevel: string = '较适宜';
    let carWashDesc: string = '天气尚可，可以洗车';

    if (weather.includes('雨') || weather.includes('雪')) {
      carWashLevel = '不宜';
      carWashDesc = '有降水，不适合洗车';
    } else if (weather === '晴') {
      carWashLevel = '适宜';
      carWashDesc = '天气晴好，适合洗车';
    }

    const carWashIndex: LifeIndex = {
      name: '洗车指数',
      level: carWashLevel,
      desc: carWashDesc,
      icon: '🚗'
    };
    lifeIndexList.push(carWashIndex);

    // 感冒指数
    let coldLevel: string = '少发';
    let coldDesc: string = '感冒不易发生';
    const tempDiff: number = parseInt(config.highTemp) - parseInt(config.lowTemp);

    if (tempDiff > 12) {
      coldLevel = '易发';
      coldDesc = '昼夜温差大，注意保暖';
    } else if (temp < 10 || humidity < 30) {
      coldLevel = '较易发';
      coldDesc = '注意增添衣物';
    }

    const coldIndex: LifeIndex = {
      name: '感冒指数',
      level: coldLevel,
      desc: coldDesc,
      icon: '🤒'
    };
    lifeIndexList.push(coldIndex);

    // 旅游指数
    let travelLevel: string = '一般';
    let travelDesc: string = '天气一般，出行需注意';

    if (weather === '晴' && temp >= 15 && temp <= 28) {
      travelLevel = '非常适宜';
      travelDesc = '天气极好，非常适合出游';
    } else if (!weather.includes('雨') && !weather.includes('雪') && temp >= 10 && temp <= 32) {
      travelLevel = '适宜';
      travelDesc = '天气较好，适合出游';
    }

    const travelIndex: LifeIndex = {
      name: '旅游指数',
      level: travelLevel,
      desc: travelDesc,
      icon: '✈️'
    };
    lifeIndexList.push(travelIndex);

    return lifeIndexList;
  }

  // 获取当前时间
  private static getCurrentTime(): string {
    const now = new Date();
    const hours: string = now.getHours().toString().padStart(2, '0');
    const minutes: string = now.getMinutes().toString().padStart(2, '0');
    return `${hours}:${minutes}`;
  }

  // 搜索城市
  static searchCity(keyword: string): CityInfo[] {
    if (!keyword || keyword === '') {
      return CityList;
    }
    const result: CityInfo[] = [];
    for (let i = 0; i < CityList.length; i++) {
      const city = CityList[i];
      if (city.name.includes(keyword) || city.province.includes(keyword)) {
        result.push(city);
      }
    }
    return result;
  }

  // 根据天气获取图标
  static getWeatherIcon(weather: string): string {
    if (weather === '晴') {
      return '☀️';
    }
    if (weather === '多云') {
      return '⛅';
    }
    if (weather === '阴') {
      return '☁️';
    }
    if (weather === '小雨' || weather === '中雨' || weather === '大雨') {
      return '🌧️';
    }
    if (weather === '阵雨') {
      return '🌦️';
    }
    if (weather === '雷阵雨') {
      return '⛈️';
    }
    if (weather === '小雪' || weather === '中雪' || weather === '大雪') {
      return '❄️';
    }
    if (weather === '雾') {
      return '🌫️';
    }
    if (weather === '霾') {
      return '😷';
    }
    if (weather === '晴转多云' || weather === '多云转晴') {
      return '🌤️';
    }
    return '🌤️';
  }

  // 获取空气质量颜色
  static getAirQualityColor(quality: string): string {
    if (quality === '优') {
      return '#00cf00';
    }
    if (quality === '良') {
      return '#ffcf00';
    }
    if (quality === '轻度污染') {
      return '#ff9900';
    }
    if (quality === '中度污染') {
      return '#ff6600';
    }
    if (quality === '重度污染') {
      return '#cc0000';
    }
    if (quality === '严重污染') {
      return '#990033';
    }
    return '#999999';
  }

  // 获取背景渐变色
  static getBackgroundGradient(weather: string, hour: number): string[] {
    let color1: string = '#4A90D9';
    let color2: string = '#87CEEB';

    if (hour >= 6 && hour < 18) {
      // 白天
      if (weather.includes('晴')) {
        color1 = '#4A90D9';
        color2 = '#87CEEB';
      } else if (weather.includes('多云')) {
        color1 = '#7B98B5';
        color2 = '#A8C4D9';
      } else if (weather.includes('雨')) {
        color1 = '#5B6E7F';
        color2 = '#8899A6';
      } else if (weather.includes('雪')) {
        color1 = '#B0C4DE';
        color2 = '#E6EEF5';
      } else {
        color1 = '#6B8299';
        color2 = '#9BB5CC';
      }
    } else {
      // 夜晚
      if (weather.includes('晴')) {
        color1 = '#1a1a2e';
        color2 = '#16213e';
      } else {
        color1 = '#2d3436';
        color2 = '#636e72';
      }
    }

    const result: string[] = [color1, color2];
    return result;
  }
}
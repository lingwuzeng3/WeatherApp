// 导入网络请求模块
import { http } from '@kit.NetworkKit';
// 导入路由模块
import { router } from '@kit.ArkUI';

// ==================== 数据接口定义 ====================
// 定义天气数据的类型结构
interface WeatherInfo {
  city: string;          // 城市名
  temperature: string;   // 温度
  weather: string;       // 天气状况
  humidity: string;      // 湿度
  wind: string;          // 风向风力
  updateTime: string;    // 更新时间
}

// 定义API返回的生活指数数据结构
interface LiveIndex {
  name: string;          // 指数名称
  level: string;         // 等级
  desc: string;          // 描述
}

// ==================== 主组件 ====================
@Entry
@Component
struct Index {
  // ========== 状态变量定义 ==========
  // @State 装饰器：当变量值改变时，UI会自动刷新

  // 当前选择的城市
  @State currentCity: string = '北京';

  // 天气数据对象
  @State weatherData: WeatherInfo = {
    city: '北京',
    temperature: '--',
    weather: '加载中...',
    humidity: '--',
    wind: '--',
    updateTime: '--'
  };

  // 是否正在加载
  @State isLoading: boolean = false;

  // 错误信息
  @State errorMessage: string = '';

  // 生活指数数组
  @State lifeIndexList: LiveIndex[] = [];

  // ========== 生命周期函数 ==========
  // 页面显示时调用
  onPageShow(): void {
    // 从路由参数获取选择的城市
    const params = router.getParams() as Record<string, string>;
    if (params && params['city']) {
      this.currentCity = params['city'];
    }
    // 获取天气数据
    this.getWeatherData();
  }

  // ========== 网络请求方法 ==========
  // 获取天气数据
  getWeatherData(): void {
    // 设置加载状态
    this.isLoading = true;
    this.errorMessage = '';

    // 创建HTTP请求对象
    const httpRequest = http.createHttp();

    // 使用免费的天气API（这里使用模拟数据演示）
    // 真实项目中替换为实际的天气API
    const apiUrl = `https://restapi.amap.com/v3/weather/weatherInfo?city=${encodeURIComponent(this.currentCity)}&key=YOUR_API_KEY`;

    // 由于API可能需要申请key，这里我们用模拟数据
    // 模拟网络请求延迟
    setTimeout(() => {
      this.simulateWeatherData();
    }, 1000);
  }

  // 模拟天气数据（实际项目替换为真实API调用）
  simulateWeatherData(): void {
    // 模拟不同城市的天气数据
    const weatherMap: Record<string, WeatherInfo> = {
      '北京': {
        city: '北京',
        temperature: '22',
        weather: '晴',
        humidity: '45%',
        wind: '北风 2级',
        updateTime: this.getCurrentTime()
      },
      '上海': {
        city: '上海',
        temperature: '26',
        weather: '多云',
        humidity: '65%',
        wind: '东南风 3级',
        updateTime: this.getCurrentTime()
      },
      '广州': {
        city: '广州',
        temperature: '30',
        weather: '阵雨',
        humidity: '80%',
        wind: '南风 2级',
        updateTime: this.getCurrentTime()
      },
      '深圳': {
        city: '深圳',
        temperature: '29',
        weather: '多云',
        humidity: '75%',
        wind: '西南风 2级',
        updateTime: this.getCurrentTime()
      },
      '杭州': {
        city: '杭州',
        temperature: '24',
        weather: '晴',
        humidity: '55%',
        wind: '东风 1级',
        updateTime: this.getCurrentTime()
      }
    };

    // 获取对应城市的天气，如果没有则使用默认值
    if (weatherMap[this.currentCity]) {
      this.weatherData = weatherMap[this.currentCity];
    } else {
      this.weatherData = {
        city: this.currentCity,
        temperature: '25',
        weather: '晴',
        humidity: '50%',
        wind: '微风',
        updateTime: this.getCurrentTime()
      };
    }

    // 设置生活指数
    this.lifeIndexList = [
      { name: '穿衣指数', level: '舒适', desc: '建议穿薄外套或衬衫' },
      { name: '紫外线', level: '中等', desc: '涂擦SPF大于15的防晒霜' },
      { name: '运动指数', level: '适宜', desc: '天气较好，适合户外运动' },
      { name: '洗车指数', level: '适宜', desc: '天气较好，适合洗车' }
    ];

    // 关闭加载状态
    this.isLoading = false;
  }

  // 获取当前时间字符串
  getCurrentTime(): string {
    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    return `${hours}:${minutes}`;
  }

  // 根据天气返回对应的图标（使用文字代替）
  getWeatherIcon(weather: string): string {
    const iconMap: Record<string, string> = {
      '晴': '☀️',
      '多云': '⛅',
      '阴': '☁️',
      '阵雨': '🌧️',
      '雷阵雨': '⛈️',
      '小雨': '🌧️',
      '中雨': '🌧️',
      '大雨': '🌧️',
      '雪': '❄️',
      '雾': '🌫️'
    };
    return iconMap[weather] || '🌤️';
  }

  // ========== UI构建 ==========
  build() {
    // 使用Navigation作为根容器
    Navigation() {
      // 主要内容区域
      Column() {
        // ===== 顶部城市选择区域 =====
        Row() {
          // 城市名称，点击可切换城市
          Text(this.currentCity)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          // 下拉箭头图标
          Text(' ▼')
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(16)
        .onClick(() => {
          // 点击跳转到城市选择页面
          router.pushUrl({
            url: 'pages/CitySelect'
          });
        })

        // ===== 天气主信息卡片 =====
        Column() {
          // 加载中显示
          if (this.isLoading) {
            // 加载动画
            LoadingProgress()
              .width(60)
              .height(60)
              .color('#1890ff')

            Text('加载中...')
              .fontSize(16)
              .fontColor('#666666')
              .margin({ top: 16 })
          }
          // 错误信息显示
          else if (this.errorMessage) {
            Text(this.errorMessage)
              .fontSize(16)
              .fontColor('#ff4d4f')

            // 重试按钮
            Button('重新加载')
              .margin({ top: 16 })
              .onClick(() => {
                this.getWeatherData();
              })
          }
          // 正常显示天气信息
          else {
            // 天气图标
            Text(this.getWeatherIcon(this.weatherData.weather))
              .fontSize(80)
              .margin({ bottom: 16 })

            // 温度显示
            Row() {
              Text(this.weatherData.temperature)
                .fontSize(72)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              Text('°C')
                .fontSize(28)
                .fontColor('#666666')
                .margin({ top: 10 })
            }

            // 天气状况
            Text(this.weatherData.weather)
              .fontSize(24)
              .fontColor('#666666')
              .margin({ top: 8 })

            // 更新时间
            Text(`更新时间: ${this.weatherData.updateTime}`)
              .fontSize(12)
              .fontColor('#999999')
              .margin({ top: 16 })
          }
        }
        .width('90%')
        .padding(32)
        .backgroundColor('#ffffff')
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: 2
        })
        .margin({ top: 16 })

        // ===== 天气详情卡片 =====
        if (!this.isLoading && !this.errorMessage) {
          Row() {
            // 湿度
            Column() {
              Text('💧')
                .fontSize(24)
              Text('湿度')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 4 })
              Text(this.weatherData.humidity)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ top: 4 })
            }
            .layoutWeight(1)

            // 分隔线
            Divider()
              .vertical(true)
              .height(50)
              .color('#eeeeee')

            // 风力
            Column() {
              Text('🍃')
                .fontSize(24)
              Text('风力')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 4 })
              Text(this.weatherData.wind)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#ffffff')
          .borderRadius(16)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: 2
          })
          .margin({ top: 16 })

          // ===== 生活指数区域 =====
          Column() {
            Text('生活指数')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .textAlign(TextAlign.Start)
              .margin({ bottom: 12 })

            // 使用Grid布局显示生活指数
            Grid() {
              ForEach(this.lifeIndexList, (item: LiveIndex) => {
                GridItem() {
                  Column() {
                    Text(item.name)
                      .fontSize(14)
                      .fontColor('#666666')

                    Text(item.level)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1890ff')
                      .margin({ top: 4 })

                    Text(item.desc)
                      .fontSize(10)
                      .fontColor('#999999')
                      .margin({ top: 4 })
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .padding(12)
                  .width('100%')
                  .height('100%')
                  .backgroundColor('#f5f5f5')
                  .borderRadius(8)
                }
              })
            }
            .columnsTemplate('1fr 1fr')  // 两列布局
            .rowsTemplate('1fr 1fr')      // 两行布局
            .columnsGap(12)               // 列间距
            .rowsGap(12)                  // 行间距
            .width('100%')
            .height(180)
          }
          .width('90%')
          .padding(16)
          .backgroundColor('#ffffff')
          .borderRadius(16)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: 2
          })
          .margin({ top: 16, bottom: 16 })
        }

        // ===== 刷新按钮 =====
        Button('刷新天气')
          .width('90%')
          .height(48)
          .fontSize(16)
          .fontColor('#ffffff')
          .backgroundColor('#1890ff')
          .borderRadius(24)
          .margin({ top: 16 })
          .onClick(() => {
            this.getWeatherData();
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f0f2f5')
    }
    .title('天气预报')      // 导航栏标题
    .titleMode(NavigationTitleMode.Mini)  // 小标题模式
    .hideBackButton(true)  // 隐藏返回按钮（主页面）
  }
}
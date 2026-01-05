// 导入路由模块
import { router } from '@kit.ArkUI';
// 导入天气服务
import { WeatherService } from '../common/WeatherService';
//导入数据模型
import { CurrentWeather, ForecastWeather, LifeIndex, WeatherData } from '../model/WeatherModel';

// 路由参数接口
interface RouterParams {
  city?: string;
}


@Entry
@Component
struct Index {

  @State currentCity: string = '北京';

  @State currentWeather: CurrentWeather = {
    city: '北京',
    temperature: '--',
    weather: '加载中',
    humidity: '--',
    windDirection: '--',
    windPower: '--',
    updateTime: '--:--',
    highTemp: '--',
    lowTemp: '--',
    airQuality: '--',
    airQualityIndex: '--'
  };

  @State forecastList: ForecastWeather[] = [];
  @State lifeIndexList: LifeIndex[] = [];
  @State isLoading: boolean = true;
  @State errorMessage: string = '';
  @State currentHour: number = new Date().getHours();

  // 背景色
  @State bgColor1: string = '#4A90D9';
  @State bgColor2: string = '#87CEEB';

  //生命周期
  aboutToAppear(): void {
    this.loadWeatherData();
  }

  onPageShow(): void {
    const params: RouterParams = router.getParams() as RouterParams;
    if (params && params.city && params.city !== this.currentCity) {
      this.currentCity = params.city;
      this.loadWeatherData();
    }
  }

  //更新背景色
  updateBackgroundColors(): void {
    const colors: string[] = WeatherService.getBackgroundGradient(
      this.currentWeather.weather,
      this.currentHour
    );
    this.bgColor1 = colors[0];
    this.bgColor2 = colors[1];
  }

  //加载天气数据
  async loadWeatherData(): Promise<void> {
    this.isLoading = true;
    this.errorMessage = '';

    try {
      const data: WeatherData = await WeatherService.getWeatherData(this.currentCity);
      this.currentWeather = data.current;
      this.forecastList = data.forecast;
      this.lifeIndexList = data.lifeIndex;
      this.isLoading = false;
      this.updateBackgroundColors();
    } catch (error) {
      this.errorMessage = '获取天气数据失败，请重试';
      this.isLoading = false;
    }
  }

  // UI构建
  build() {
    Stack() {
      // 渐变背景
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Top,
          colors: [
            [this.bgColor1, 0.0],
            [this.bgColor2, 1.0]
          ]
        })

      // 主内容
      Column() {
        //顶部城市选择
        Row() {
          Row() {
            Text('📍')
              .fontSize(18)
            Text(this.currentCity)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ left: 4 })
            Text(' ▼')
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.8)')
          }
          .onClick(() => {
            router.pushUrl({ url: 'pages/CitySelect' });
          })

          Blank()

          Text('🔄')
            .fontSize(24)
            .onClick(() => {
              this.loadWeatherData();
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })

        // 可滚动内容区
        Scroll() {
          Column() {
            if (this.isLoading) {
              // 加载中
              Column() {
                LoadingProgress()
                  .width(60)
                  .height(60)
                  .color(Color.White)
                Text('正在获取天气数据...')
                  .fontSize(16)
                  .fontColor('rgba(255,255,255,0.8)')
                  .margin({ top: 16 })
              }
              .height(300)
              .justifyContent(FlexAlign.Center)
            } else if (this.errorMessage !== '') {
              // 错误显示
              Column() {
                Text('😕')
                  .fontSize(60)
                Text(this.errorMessage)
                  .fontSize(16)
                  .fontColor(Color.White)
                  .margin({ top: 16 })
                Button('重新加载')
                  .margin({ top: 24 })
                  .backgroundColor('rgba(255,255,255,0.3)')
                  .onClick(() => {
                    this.loadWeatherData();
                  })
              }
              .height(300)
              .justifyContent(FlexAlign.Center)
            } else {
              // 当前天气卡片
              Column() {
                Text(WeatherService.getWeatherIcon(this.currentWeather.weather))
                  .fontSize(80)

                Row() {
                  Text(this.currentWeather.temperature)
                    .fontSize(80)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                  Text('°')
                    .fontSize(50)
                    .fontColor(Color.White)
                    .margin({ top: 10 })
                }

                Text(this.currentWeather.weather)
                  .fontSize(24)
                  .fontColor(Color.White)

                Row() {
                  Text(this.currentWeather.highTemp + '°')
                    .fontSize(16)
                    .fontColor('rgba(255,255,255,0.9)')
                  Text(' / ')
                    .fontSize(16)
                    .fontColor('rgba(255,255,255,0.6)')
                  Text(this.currentWeather.lowTemp + '°')
                    .fontSize(16)
                    .fontColor('rgba(255,255,255,0.7)')
                }
                .margin({ top: 8 })

                Row() {
                  Text('空气')
                    .fontSize(12)
                    .fontColor('rgba(255,255,255,0.7)')
                  Text(' ' + this.currentWeather.airQuality)
                    .fontSize(12)
                    .fontColor(WeatherService.getAirQualityColor(this.currentWeather.airQuality))
                    .fontWeight(FontWeight.Medium)
                  Text(' ' + this.currentWeather.airQualityIndex)
                    .fontSize(12)
                    .fontColor('rgba(255,255,255,0.7)')
                }
                .margin({ top: 12 })
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor('rgba(0,0,0,0.15)')
                .borderRadius(20)

                Text('更新于 ' + this.currentWeather.updateTime)
                  .fontSize(12)
                  .fontColor('rgba(255,255,255,0.5)')
                  .margin({ top: 16 })
              }
              .width('100%')
              .padding({ top: 20, bottom: 30 })

              // 天气详情卡片
              Row() {
                Column() {
                  Text('💧')
                    .fontSize(24)
                  Text('湿度')
                    .fontSize(12)
                    .fontColor('rgba(255,255,255,0.7)')
                    .margin({ top: 8 })
                  Text(this.currentWeather.humidity + '%')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.White)
                    .margin({ top: 4 })
                }
                .layoutWeight(1)

                Divider()
                  .vertical(true)
                  .height(50)
                  .color('rgba(255,255,255,0.2)')

                Column() {
                  Text('🍃')
                    .fontSize(24)
                  Text('风力')
                    .fontSize(12)
                    .fontColor('rgba(255,255,255,0.7)')
                    .margin({ top: 8 })
                  Text(this.currentWeather.windDirection)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.White)
                    .margin({ top: 4 })
                  Text(this.currentWeather.windPower)
                    .fontSize(12)
                    .fontColor('rgba(255,255,255,0.7)')
                }
                .layoutWeight(1)
              }
              .width('90%')
              .padding(20)
              .backgroundColor('rgba(255,255,255,0.15)')
              .borderRadius(16)

              //7天预报
              Column() {
                Text('7天预报')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .margin({ bottom: 16 })

                ForEach(this.forecastList, (item: ForecastWeather, index: number) => {
                  Row() {
                    Column() {
                      Text(item.week)
                        .fontSize(14)
                        .fontColor(Color.White)
                        .fontWeight(index === 0 ? FontWeight.Bold : FontWeight.Normal)
                      Text(item.date)
                        .fontSize(12)
                        .fontColor('rgba(255,255,255,0.6)')
                        .margin({ top: 2 })
                    }
                    .width(60)
                    .alignItems(HorizontalAlign.Start)

                    Text(WeatherService.getWeatherIcon(item.dayWeather))
                      .fontSize(28)
                      .width(50)

                    Text(item.dayWeather)
                      .fontSize(14)
                      .fontColor(Color.White)
                      .width(70)

                    Blank()

                    Row() {
                      Text(item.lowTemp + '°')
                        .fontSize(14)
                        .fontColor('rgba(255,255,255,0.6)')
                      Row()
                        .width(60)
                        .height(4)
                        .backgroundColor('rgba(255,255,255,0.3)')
                        .borderRadius(2)
                        .margin({ left: 8, right: 8 })
                      Text(item.highTemp + '°')
                        .fontSize(14)
                        .fontColor(Color.White)
                    }
                  }
                  .width('100%')
                  .height(60)
                  .padding({ left: 4, right: 4 })
                })
              }
              .width('90%')
              .padding(16)
              .backgroundColor('rgba(255,255,255,0.15)')
              .borderRadius(16)
              .margin({ top: 16 })

              // 生活指数
              Column() {
                Text('生活指数')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .margin({ bottom: 16 })

                Grid() {
                  ForEach(this.lifeIndexList, (item: LifeIndex) => {
                    GridItem() {
                      Column() {
                        Text(item.icon)
                          .fontSize(28)
                        Text(item.name)
                          .fontSize(12)
                          .fontColor('rgba(255,255,255,0.7)')
                          .margin({ top: 8 })
                        Text(item.level)
                          .fontSize(14)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(Color.White)
                          .margin({ top: 4 })
                        Text(item.desc)
                          .fontSize(10)
                          .fontColor('rgba(255,255,255,0.5)')
                          .margin({ top: 4 })
                          .maxLines(2)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })
                          .textAlign(TextAlign.Center)
                      }
                      .padding(12)
                      .width('100%')
                      .height('100%')
                      .backgroundColor('rgba(255,255,255,0.1)')
                      .borderRadius(12)
                    }
                  })
                }
                .columnsTemplate('1fr 1fr 1fr')
                .rowsTemplate('1fr 1fr')
                .columnsGap(10)
                .rowsGap(10)
                .width('100%')
                .height(220)
              }
              .width('90%')
              .padding(16)
              .backgroundColor('rgba(255,255,255,0.15)')
              .borderRadius(16)
              .margin({ top: 16, bottom: 30 })
            }
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
  }
}
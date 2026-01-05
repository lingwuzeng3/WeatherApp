// 导入路由模块
import { router } from '@kit.ArkUI';
// 导入数据模型
import { CityInfo, CityList } from '../model/WeatherModel';
// 导入天气服务
import { WeatherService } from '../common/WeatherService';

//=============== 城市选择页面===============
@Entry
@Component
struct CitySelect {
  //===== 状态变量=====
  // 搜索关键词
  @State searchText: string = '';

  // 搜索结果
  @State searchResults: CityInfo[] = CityList;

  // 热门城市
  @State hotCities: string[] = [
    '北京', '上海', '广州', '深圳',
    '杭州', '南京', '武汉', '成都'
  ];

  // 历史搜索（模拟数据）
  @State historyList: string[] = ['北京', '上海'];

  //===== 搜索城市=====
  searchCity(keyword: string): void {
    this.searchResults = WeatherService.searchCity(keyword);
  }

  //===== 选择城市=====
  selectCity(cityName: string): void {
    // 添加到历史记录
    if (!this.historyList.includes(cityName)) {
      this.historyList.unshift(cityName);
      if (this.historyList.length > 5) {
        this.historyList.pop();
      }
    }

    // 返回主页并传递城市
    router.back({
      url: 'pages/Index',
      params: { city: cityName }
    });
  }

  //===== UI构建=====
  build() {
    Column() {
      // 顶部导航栏
      Row() {
        // 返回按钮
        Text('←')
          .fontSize(28)
          .fontColor('#333333')
          .onClick(() => {
            router.back();
          })
          .padding(8)

        Text('选择城市')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ left: 12 })

        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 16 })
      .backgroundColor(Color.White)

      // 搜索框
      Row() {
        Text('🔍')
          .fontSize(18)
          .fontColor('#999999')

        TextInput({
          placeholder: '搜索城市名称',
          text: this.searchText
        })
          .layoutWeight(1)
          .height(44)
          .backgroundColor('transparent')
          .placeholderColor('#999999')
          .onChange((value: string) => {
            this.searchText = value;
            this.searchCity(value);
          })

        // 清除按钮
        if (this.searchText.length > 0) {
          Text('✕')
            .fontSize(18)
            .fontColor('#999999')
            .onClick(() => {
              this.searchText = '';
              this.searchResults = CityList;
            })
        }
      }
      .width('92%')
      .height(48)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#f5f5f5')
      .borderRadius(24)
      .margin({ top: 12, bottom: 16 })

      // 内容区域
      Scroll() {
        Column() {
          // 如果没有搜索词，显示热门城市和历史
          if (this.searchText.length === 0) {
            // 历史搜索
            if (this.historyList.length > 0) {
              Column() {
                Row() {
                  Text('历史搜索')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#333333')
                  Blank()
                  Text('清空')
                    .fontSize(14)
                    .fontColor('#999999')
                    .onClick(() => {
                      this.historyList = [];
                    })
                }
                .width('100%')
                .margin({ bottom: 12 })

                Flex({ wrap: FlexWrap.Wrap }) {
                  ForEach(this.historyList, (city: string) => {
                    Text(city)
                      .fontSize(14)
                      .fontColor('#666666')
                      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                      .backgroundColor('#f0f0f0')
                      .borderRadius(16)
                      .margin({ right: 10, bottom: 10 })
                      .onClick(() => {
                        this.selectCity(city);
                      })
                  })
                }
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .margin({ bottom: 12 })
            }

            // 热门城市
            Column() {
              Text('热门城市')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 16 })

              Grid() {
                ForEach(this.hotCities, (city: string) => {
                  GridItem() {
                    Column() {
                      Text('🏙️')
                        .fontSize(28)
                      Text(city)
                        .fontSize(14)
                        .fontColor('#333333')
                        .margin({ top: 8 })
                    }
                    .width('100%')
                    .height('100%')
                    .justifyContent(FlexAlign.Center)
                    .backgroundColor('#f8f8f8')
                    .borderRadius(12)
                  }
                  .onClick(() => {
                    this.selectCity(city);
                  })
                })
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .rowsTemplate('1fr 1fr')
              .columnsGap(12)
              .rowsGap(12)
              .width('100%')
              .height(180)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ bottom: 12 })

            // 全部城市列表
            Column() {
              Text('全部城市')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 12 })

              ForEach(this.searchResults, (city: CityInfo) => {
                Row() {
                  Text('📍')
                    .fontSize(18)

                  Column() {
                    Text(city.name)
                      .fontSize(16)
                      .fontColor('#333333')
                    Text(city.province)
                      .fontSize(12)
                      .fontColor('#999999')
                      .margin({ top: 2 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 12 })

                  Blank()

                  Text('›')
                    .fontSize(24)
                    .fontColor('#cccccc')
                }
                .width('100%')
                .height(64)
                .padding({ left: 12, right: 12 })
                .onClick(() => {
                  this.selectCity(city.name);
                })

                Divider()
                  .color('#f0f0f0')
                  .margin({ left: 44 })
              })
            }
            .width('100%')
            .padding({ top: 16, bottom: 16 })
            .backgroundColor(Color.White)
            .borderRadius(12)
          }
          // 显示搜索结果
          else {
            Column() {
              if (this.searchResults.length === 0) {
                // 无结果
                Column() {
                  Text('🔍')
                    .fontSize(60)
                  Text('未找到相关城市')
                    .fontSize(16)
                    .fontColor('#999999')
                    .margin({ top: 16 })
                }
                .height(200)
                .justifyContent(FlexAlign.Center)
              } else {
                Text(`找到 ${this.searchResults.length} 个城市`)
                  .fontSize(14)
                  .fontColor('#999999')
                  .width('100%')
                  .margin({ bottom: 12 })

                ForEach(this.searchResults, (city: CityInfo) => {
                  Row() {
                    Text('📍')
                      .fontSize(18)

                    Column() {
                      // 高亮显示匹配的文字
                      Text(city.name)
                        .fontSize(16)
                        .fontColor('#333333')
                      Text(city.province)
                        .fontSize(12)
                        .fontColor('#999999')
                        .margin({ top: 2 })
                    }
                    .alignItems(HorizontalAlign.Start)
                    .margin({ left: 12 })

                    Blank()

                    Text('›')
                      .fontSize(24)
                      .fontColor('#cccccc')
                  }
                  .width('100%')
                  .height(64)
                  .padding({ left: 12, right: 12 })
                  .backgroundColor(Color.White)
                  .onClick(() => {
                    this.selectCity(city.name);
                  })

                  Divider()
                    .color('#f0f0f0')
                    .margin({ left: 44 })
                })
              }
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
          }
        }
        .padding({ left: 16, right: 16, bottom: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f0f2f5')
  }
}
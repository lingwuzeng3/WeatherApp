// 导入路由模块
import { router } from '@kit.ArkUI';

// ==================== 城市选择页面 ====================
@Entry
@Component
struct CitySelect {
  // ========== 状态变量 ==========

  // 热门城市列表
  @State cityList: string[] = [
    '北京', '上海', '广州', '深圳',
    '杭州', '南京', '武汉', '成都',
    '西安', '重庆', '天津', '苏州'
  ];

  // 搜索关键词
  @State searchText: string = '';

  // 根据搜索过滤后的城市列表
  get filteredCities(): string[] {
    if (this.searchText === '') {
      return this.cityList;
    }
    return this.cityList.filter(city =>
    city.includes(this.searchText)
    );
  }

  // ========== UI构建 ==========
  build() {
    Navigation() {
      Column() {
        // ===== 搜索框 =====
        Row() {
          // 搜索图标
          Text('🔍')
            .fontSize(18)
            .margin({ right: 8 })

          // 搜索输入框
          TextInput({ placeholder: '搜索城市', text: this.searchText })
            .layoutWeight(1)
            .height(40)
            .backgroundColor('transparent')
            .onChange((value: string) => {
              this.searchText = value;
            })
        }
        .width('90%')
        .padding({ left: 16, right: 16 })
        .backgroundColor('#f5f5f5')
        .borderRadius(20)
        .margin({ top: 16, bottom: 16 })

        // ===== 热门城市标题 =====
        Text('热门城市')
          .fontSize(16)
          .fontColor('#999999')
          .width('90%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 12 })

        // ===== 城市列表 =====
        List() {
          ForEach(this.filteredCities, (city: string) => {
            ListItem() {
              Row() {
                // 城市图标
                Text('📍')
                  .fontSize(18)
                  .margin({ right: 12 })

                // 城市名称
                Text(city)
                  .fontSize(18)
                  .fontColor('#333333')

                // 占位，让箭头靠右
                Blank()

                // 右箭头
                Text('›')
                  .fontSize(24)
                  .fontColor('#cccccc')
              }
              .width('100%')
              .height(56)
              .padding({ left: 16, right: 16 })
              .backgroundColor('#ffffff')
            }
            .onClick(() => {
              // 点击城市，返回主页并传递选中的城市
              router.back({
                url: 'pages/Index',
                params: {
                  city: city
                }
              });
            })
          })
        }
        .width('100%')
        .layoutWeight(1)
        .divider({
          strokeWidth: 1,
          color: '#f0f0f0',
          startMargin: 56,
          endMargin: 0
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f0f2f5')
    }
    .title('选择城市')
    .titleMode(NavigationTitleMode.Mini)
  }
}
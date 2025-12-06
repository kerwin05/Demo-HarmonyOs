import router from '@ohos.router'

@Entry
@Component
struct Home {
  build() {
    Column() {
      // 标题
      Text('欢迎使用')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ bottom: 80 })

      // 按钮容器
      Column() {
        // 进入计算器按钮
        Button('进入计算器')
          .width('80%')
          .height(60)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#FF6B35')
          .borderRadius(30)
          .margin({ bottom: 30 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Calculator'
            }).catch((err: Error) => {
              console.error(`跳转失败: ${err.message}`)
            })
          })

        // 测试MBTI按钮
        Button('测试MBTI')
          .width('80%')
          .height(60)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#4A5568')
          .borderRadius(30)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/EmptyPage'
            }).catch((err: Error) => {
              console.error(`跳转失败: ${err.message}`)
            })
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [['#1a1a2e', 0.0], ['#16213e', 0.5], ['#0f3460', 1.0]]
    })
  }
}


import router from '@ohos.router'

@Entry
@Component
struct EmptyPage {
  build() {
    Scroll() {
      Column() {
        // 顶部Header
        this.buildHeader()
        
        // 主要内容区域（青色背景）
        this.buildMainContent()
        
        // 底部Footer（白色背景）
        this.buildFooter()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // 构建顶部Header
  @Builder
  buildHeader() {
    Row() {
      // Logo区域 - 16个彩色圆点（使用Row和Column组合）
      Stack() {
        // 中心圆点
        Row()
          .width(8)
          .height(8)
          .borderRadius(4)
          .backgroundColor('#4A90E2')
        
        // 围绕的小圆点（简化版，用8个代表）
        Row() {
          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
            Row()
              .width(4)
              .height(4)
              .borderRadius(2)
              .backgroundColor(this.getLogoColor(index))
              .margin({ left: index > 0 ? 2 : 0 })
          })
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
      }
      .width(40)
      .height(40)
      .margin({ right: 12 })

      // "16 Personalities" 文字
      Text('16 Personalities')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .layoutWeight(1)

      // 地球图标（用文字代替）
      Text('🌐')
        .fontSize(24)
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#2C9FA3')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  // 获取Logo颜色
  getLogoColor(index: number): ResourceColor {
    const colors = ['#9B59B6', '#2ECC71', '#F39C12', '#E74C3C', '#3498DB', '#1ABC9C', '#E91E63', '#FFC107']
    return colors[index % colors.length]
  }

  // 构建主要内容区域
  @Builder
  buildMainContent() {
    Column() {
      // 大引号文字
      Text('"梦寐以求的被理解之感终于降临,这种滋味妙不可言。"')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .lineHeight(42)
        .margin({ top: 50, bottom: 24, left: 24, right: 24 })

      // 说明文字
      Text('仅需10分钟,你便能收获一份入木三分的描述,它将精准剖析你是何人,以及你所作所为背后的缘由。')
        .fontSize(18)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .lineHeight(30)
        .opacity(0.95)
        .margin({ bottom: 32, left: 24, right: 24 })

      // 底部插画区域（简化版）
      this.buildIllustration()
    }
    .width('100%')
    .padding({ bottom: 32 })
    .backgroundColor('#2C9FA3')
  }

  // 构建插画区域
  @Builder
  buildIllustration() {
    Stack() {
      // 背景：青色山脉和白色雪地
      Column() {
        // 山脉（使用Row和Column组合实现）
        Row() {
          // 左侧山脉
          Column() {
            Row()
              .width(80)
              .height(40)
              .backgroundColor('#1E7A7D')
              .borderRadius({ topLeft: 0, topRight: 20, bottomLeft: 0, bottomRight: 0 })
          }
          .width(80)
          .height(40)
          .alignItems(HorizontalAlign.Start)
          
          // 中间山脉
          Column() {
            Row()
              .width(80)
              .height(50)
              .backgroundColor('#1E7A7D')
              .borderRadius({ topLeft: 0, topRight: 25, bottomLeft: 0, bottomRight: 0 })
          }
          .width(80)
          .height(50)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: -20 })
          
          // 右侧山脉
          Column() {
            Row()
              .width(80)
              .height(35)
              .backgroundColor('#1E7A7D')
              .borderRadius({ topLeft: 0, topRight: 18, bottomLeft: 0, bottomRight: 0 })
          }
          .width(80)
          .height(35)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: -20 })
        }
        .width('100%')
        .height(80)
        .margin({ top: 16 })
        .justifyContent(FlexAlign.Start)

        // 雪地
        Row()
          .width('100%')
          .height(60)
          .backgroundColor('#E8F4F5')
          .margin({ top: -20 })
      }
      .width('100%')
      .height(200)

      // 前景：各种人物和元素
      Column() {
        Row() {
          // 左侧人物（绿色巫师）
          this.buildCharacter('#2ECC71', 30, 50, { left: 20 })

          // 中间篝火
          Column() {
            // 火焰（用三角形形状的Row实现）
            Row()
              .width(30)
              .height(20)
              .backgroundColor('#F39C12')
              .borderRadius({ topLeft: 15, topRight: 15, bottomLeft: 0, bottomRight: 0 })
            // 木柴
            Row()
              .width(30)
              .height(8)
              .backgroundColor('#8B4513')
              .borderRadius(2)
              .margin({ top: -5 })
          }
          .margin({ left: 40 })

          // 右侧人物（蓝色制服）
          this.buildCharacter('#3498DB', 30, 50, { left: 40 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ top: 80 })

        // 底部人物
        Row() {
          // 黄色人物（躺着）
          this.buildCharacter('#F39C12', 25, 40, { left: 30 })

          // 紫色人物（拿着盘子）
          this.buildCharacter('#9B59B6', 30, 50, { left: 50 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .margin({ top: 16 })
      }
      .width('100%')
    }
    .width('100%')
    .height(200)
    .margin({ top: 16, bottom: 8 })
  }

  // 构建人物角色（简化版，用圆形和矩形表示）
  @Builder
  buildCharacter(color: ResourceColor, width: number, height: number, marginValue?: Margin) {
    Column() {
      // 头部（用Row实现圆形）
      Row()
        .width(width * 0.4)
        .height(width * 0.4)
        .borderRadius(width * 0.2)
        .backgroundColor(color)
      
      // 身体
      Row()
        .width(width * 0.6)
        .height(height * 0.6)
        .backgroundColor(color)
        .borderRadius(4)
        .margin({ top: -2 })
    }
    .width(width)
    .height(height)
    .margin(marginValue || {})
  }

  // 构建底部Footer
  @Builder
  buildFooter() {
    Column() {
      // 四列链接
      Row() {
        // Products列
        Column() {
          Text('Products')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 16 })
          
          this.buildFooterLink('Premium Career Suite')
          this.buildFooterLink('Team Assessments')
          this.buildFooterLink('Reports for Professionals')
          this.buildFooterLink('Testimonials')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ right: 12 })

        // Resources列
        Column() {
          Text('Resources')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 16 })
          
          this.buildFooterLink('Personality Test')
          this.buildFooterLink('Personality Types')
          this.buildFooterLink('Articles')
          this.buildFooterLink('Our Framework')
          this.buildFooterLink('Country Profiles')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ right: 12 })

        // Help列
        Column() {
          Text('Help')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 16 })
          
          this.buildFooterLink('Contact Us')
          this.buildFooterLink('FAQ')
          this.buildFooterLink('Your Orders')
          this.buildFooterLink('Change Language')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ right: 12 })

        // Our Other Creations列
        Column() {
          Text('Our Other Creations')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 16 })
          
          this.buildFooterLink('NPQE®')
          this.buildFooterLink('MindTrackers®')
          this.buildFooterLink('Leadership by 16Personalities')
          this.buildFooterLink('Grow with 16Personalities')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 32, bottom: 32 })
      .justifyContent(FlexAlign.SpaceBetween)

      // 返回按钮
      Button('返回')
        .width('60%')
        .height(50)
        .fontSize(20)
        .fontColor('#FFFFFF')
        .backgroundColor('#2C9FA3')
        .borderRadius(25)
        .margin({ top: 24, bottom: 32 })
        .onClick(() => {
          router.back()
        })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  // 构建Footer链接
  @Builder
  buildFooterLink(text: string) {
    Text(text)
      .fontSize(14)
      .fontColor('#666666')
      .margin({ bottom: 10 })
      .onClick(() => {
        // 链接点击事件（静态页面，不实现实际跳转）
      })
  }
}

@Entry
@Component
struct Calculator {
  // 显示的计算结果
  @State displayValue: string = '0'
  // 当前输入的字符串
  @State currentInput: string = '0'
  // 上一个值
  @State previousValue: number = 0
  // 当前操作符
  @State operator: string = ''
  // 是否等待新输入
  @State waitingForNewValue: boolean = false

  // V2 语法：使用 build() 方法，但使用更简洁的语法
  build() {
    Column() {
      // 显示屏区域 - 使用渐变背景
      Column() {
        Text(this.displayValue)
          .fontSize(72)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.End)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
          .opacity(0.95)
      }
      .width('100%')
      .height(220)
      .padding({ left: 30, right: 30, top: 60, bottom: 30 })
      .justifyContent(FlexAlign.End)
      .linearGradient({
        angle: 180,
        colors: [['#1a1a2e', 0.0], ['#16213e', 0.5], ['#0f3460', 1.0]]
      })

      // 按钮区域 - 使用更现代的配色
      Column() {
        // 第一行：清除、退格、百分比、除
        this.buildButtonRow(['C', '⌫', '%', '÷'])
        
        // 第二行：7、8、9、乘
        this.buildButtonRow(['7', '8', '9', '×'])
        
        // 第三行：4、5、6、减
        this.buildButtonRow(['4', '5', '6', '−'])
        
        // 第四行：1、2、3、加
        this.buildButtonRow(['1', '2', '3', '+'])
        
        // 第五行：0、小数点、等于
        Row() {
          // 0 按钮占两列
          this.buildButton('0', true, false, 2)
          
          this.buildButton('.', false, false, 1)
          
          this.buildButton('=', false, true, 1)
        }
        .width('100%')
        .height(88)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 20, bottom: 20 })
      .linearGradient({
        angle: 180,
        colors: [['#0a0a0a', 0.0], ['#1a1a1a', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0a0a0a')
  }

  // 构建按钮行
  @Builder
  buildButtonRow(buttons: string[]) {
    Row() {
      ForEach(buttons, (button: string) => {
        this.buildButton(button, button === '0', 
          button === '÷' || button === '×' || button === '−' || button === '+', 1)
      })
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ bottom: 12 })
  }

  // 构建单个按钮
  @Builder
  buildButton(text: string, isWide: boolean = false, isOperator: boolean = false, layoutWeight: number = 1) {
    Button(text)
      .width('100%')
      .height('100%')
      .layoutWeight(layoutWeight)
      .margin({ left: 8, right: 8 })
      .fontSize(36)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.getButtonTextColor(text, isOperator))
      .backgroundColor(this.getButtonColor(text, isOperator))
      .borderRadius(22)
      .shadow({
        radius: isOperator ? 8 : 4,
        color: isOperator ? '#FF9500' : '#000000',
        offsetX: 0,
        offsetY: isOperator ? 4 : 2
      })
      .opacity(0.95)
      .onClick(() => {
        this.handleButtonClick(text)
      })
  }

  // 获取按钮颜色
  getButtonColor(text: string, isOperator: boolean): ResourceColor {
    if (isOperator) {
      return '#FF6B35' // 鲜艳的橙红色操作符
    }
    if (text === 'C' || text === '⌫' || text === '%') {
      return '#4A5568' // 深灰色功能键
    }
    return '#2D3748' // 深色数字键
  }

  // 获取按钮文字颜色
  getButtonTextColor(text: string, isOperator: boolean): ResourceColor {
    if (isOperator) {
      return '#FFFFFF' // 白色文字
    }
    if (text === 'C' || text === '⌫' || text === '%') {
      return '#FFFFFF' // 白色文字
    }
    return '#E2E8F0' // 浅色文字
  }

  // 处理按钮点击
  handleButtonClick(text: string) {
    if (text >= '0' && text <= '9') {
      this.handleNumber(text)
    } else if (text === '.') {
      this.handleDecimal()
    } else if (text === 'C') {
      this.handleClear()
    } else if (text === '⌫') {
      this.handleBackspace()
    } else if (text === '%') {
      this.handlePercentage()
    } else if (text === '+' || text === '−' || text === '×' || text === '÷') {
      this.handleOperator(text)
    } else if (text === '=') {
      this.handleEquals()
    }
  }

  // 处理数字输入
  handleNumber(num: string) {
    if (this.waitingForNewValue) {
      this.currentInput = '0'
      this.waitingForNewValue = false
    }
    
    // 如果当前输入是0，直接替换；否则追加
    if (this.currentInput === '0') {
      this.currentInput = num
    } else {
      this.currentInput = this.currentInput + num
    }
    
    this.updateDisplay()
  }

  // 处理小数点
  handleDecimal() {
    if (this.waitingForNewValue) {
      this.currentInput = '0'
      this.waitingForNewValue = false
    }
    
    // 如果当前输入不包含小数点，添加小数点
    if (!this.currentInput.includes('.')) {
      this.currentInput = this.currentInput + '.'
      this.updateDisplay()
    }
  }

  // 处理清除
  handleClear() {
    this.currentInput = '0'
    this.previousValue = 0
    this.operator = ''
    this.waitingForNewValue = false
    this.updateDisplay()
  }

  // 处理退格
  handleBackspace() {
    if (this.waitingForNewValue) {
      return
    }
    
    if (this.currentInput.length > 1) {
      this.currentInput = this.currentInput.slice(0, -1)
    } else {
      this.currentInput = '0'
    }
    this.updateDisplay()
  }

  // 处理百分比
  handlePercentage() {
    const value = Number(this.currentInput)
    const result = value / 100
    this.currentInput = this.formatNumber(result)
    this.updateDisplay()
  }

  // 处理操作符
  handleOperator(op: string) {
    if (this.operator && !this.waitingForNewValue) {
      this.calculate()
    }
    
    this.previousValue = Number(this.currentInput)
    this.operator = op
    this.waitingForNewValue = true
  }

  // 处理等号
  handleEquals() {
    if (this.operator) {
      this.calculate()
      this.operator = ''
      this.waitingForNewValue = true
    }
  }

  // 执行计算
  calculate() {
    const currentValue = Number(this.currentInput)
    let result = 0
    
    switch (this.operator) {
      case '+':
        result = this.previousValue + currentValue
        break
      case '−':
        result = this.previousValue - currentValue
        break
      case '×':
        result = this.previousValue * currentValue
        break
      case '÷':
        if (currentValue !== 0) {
          result = this.previousValue / currentValue
        } else {
          this.displayValue = '错误'
          this.currentInput = '0'
          return
        }
        break
    }
    
    // 处理精度问题并格式化
    result = Math.round(result * 100000000) / 100000000
    this.currentInput = this.formatNumber(result)
    this.updateDisplay()
  }

  // 格式化数字
  formatNumber(num: number): string {
    // 处理精度问题
    const rounded = Math.round(num * 100000000) / 100000000
    const valueStr = rounded.toString()
    
    // 如果是整数，直接返回
    if (!valueStr.includes('.')) {
      return valueStr
    }
    
    // 移除尾随的零
    return valueStr.replace(/\.?0+$/, '')
  }

  // 更新显示
  updateDisplay() {
    let formattedValue = this.currentInput
    
    // 如果输入是空字符串，显示0
    if (formattedValue === '') {
      formattedValue = '0'
    }
    
    // 如果输入只有小数点，显示 "0."
    if (formattedValue === '.') {
      formattedValue = '0.'
    }
    
    // 如果输入以小数点结尾（用户正在输入小数），直接显示
    if (formattedValue.endsWith('.')) {
      this.displayValue = formattedValue
      return
    }
    
    // 如果是纯数字，格式化显示（移除不必要的尾随零）
    const numValue = Number(formattedValue)
    if (!isNaN(numValue)) {
      formattedValue = this.formatNumber(numValue)
    }
    
    // 限制显示长度，如果太长则使用科学计数法
    if (formattedValue.length > 12 && !formattedValue.includes('e') && !formattedValue.includes('E')) {
      if (!isNaN(numValue)) {
        formattedValue = numValue.toExponential(6)
      }
    }
    
    this.displayValue = formattedValue
  }
}


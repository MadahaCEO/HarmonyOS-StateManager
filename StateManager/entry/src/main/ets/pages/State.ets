@Entry
@Component
struct StateSample {
  @State message: string = 'Hello World'
  @State fontSize: number = 50
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(this.fontSize)
          .fontWeight(FontWeight.Bold)
        Button('Touch').onClick((event: ClickEvent) => {
          this.message = 'Hello HarmonyOS'
          this.fontSize = 30
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  private arr: String[] = ['@State','@Prop & @Link',' @Provide & @Consume','@Observed & @ObjectLink']
  private pages: string[] = ['pages/State']

  build() {
    Column({space: 20}) {
        Text('状态管理')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        ForEach(this.arr, (str,idx) => {
          Button(str)
            .onClick( ()=> {
              console.log(str, idx, this.pages[idx])
              router.pushUrl({
                url: this.pages[idx],
              })
            })
        })
    }
    .width('100%')

  }
}
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  private arr: String[] = ['@State','@StateTask','@Prop & @Link',' @Provide & @Consume','@Observed & @ObjectLink', 'Navigation']
  private pages: string[] = ['pages/State','pages/StateTask','pages/PropLink','pages/ProvideConsume','pages/ObservedObjectLink', 'pages/Navigation']

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
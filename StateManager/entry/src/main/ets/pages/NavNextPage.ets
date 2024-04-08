import router from '@ohos.router'
@Entry
@Component
struct NavNextPage {

  data: string = router.getParams()['title']

  build() {
    Column({space: 40}) {
      Text(this.data)

      Button('返回').onClick(() => {
        router.back()
      })

      Button('返回提示').onClick(() => {
        router.showAlertBeforeBackPage({message:'确认退出？'})
      })
    }

  }
}
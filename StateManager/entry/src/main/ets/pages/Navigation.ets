import router from '@ohos.router'

@Entry
@Component
struct NavPage {

  /*
   * router.pushUrl() 压栈 ,打开新页面
   * router.replaceUrl() 替换当前栈，当前页面会被销毁，打开新页面
   * */

  build() {
    Column({space: 20}) {
      Button('传递基础参数').onClick(()=> {
router.pushUrl({
  url:'pages/NavNextPage',
  params:{title: 'dsf'}
},
router.RouterMode.Single,
  err => {
    if (err) {
      /*
       * 100001 内部错误
       * 100002 路由地址错误
       * 100003 路由栈总数超过32
       * */
      console.log(`跳转失败  code: ${err.code}  msg: ${err.message}`)
    }
  }
)

      })
    }
  }
}
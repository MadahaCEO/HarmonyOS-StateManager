
export class Task {
  // 静态变量，当前类的所有对象共享，无论创建多少个Task对象
  static id: number = 1
  // 任务名称
  name: string = `任务 ${Task.id++}`
  // 任务是否完成
  finished: boolean = false
}



/* @Styles重用样式函数
 * 将多条样式设置提炼成⼀个方法，直接在组件声明的位置调用。
 * 这是组件外定义，必须加上 function （组件内不用加function关键字）
 * */

@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({
    radius: 6,
    color: '#1F000000',
    offsetX:2,
    offsetY: 4
  })
}

/* 扩展原生组件样式
 * 仅支持定义在全局，不支持在组件内部定义。
 * 支持封装指定的组件的私有属性和私有事件和预定义相同组件的@Extend的方法。
 * 支持参数，开发者可以在调用时传递参数
 * */
@Extend(Text) function finishedTask() {
  .decoration({type: TextDecorationType.LineThrough})
  .fontColor('B1B2B1')
}

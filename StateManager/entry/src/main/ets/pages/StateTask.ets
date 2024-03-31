import {Task} from "../common/Common"

@Styles function card1() {
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

@Extend(Text) function finishedTask1() {
  .decoration({type: TextDecorationType.LineThrough})
  .fontColor('B1B2B1')
}


@Entry
@Component
struct StateTask {

  @State totalTask: number = 0
  @State finishTask: number = 0
  @State tasks: Task[] = []

  handleTasks() {

    this.totalTask = this.tasks.length
    this.finishTask = this.tasks.filter(item => item.finished).length

  }

  build() {
    Column({space: 10}) {
      // 1.任务进度卡片
      Row() {
        Text('任务进度: ')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Stack() {
          Progress({
            value: this.finishTask,
            total: this.totalTask,
            type: ProgressType.Ring
          })
            .width(100)
          Row() {
            Text(this.finishTask.toString())
              .fontSize(24)
              .fontColor('#36D')
            Text(' / ' + this.totalTask.toString())
              .fontSize(24)
          }
        }
      }
      .card1()
      .margin({top: 20,bottom: 10})
      .justifyContent(FlexAlign.SpaceEvenly)

      // 2.新增任务按钮
      Button('新增任务').onClick((event: ClickEvent) => {
        this.tasks.push(new Task())
        this.handleTasks()
      })
        .width(200)

      // 3.任务列表
      List({space: 10}) {
        ForEach(
          this.tasks,
          (item: Task, idx) => {
            ListItem() {
              Row(){
                Text(item.name)
                  .fontSize(20)
                Checkbox()
                  .select(item.finished)
                  .onChange((val)=>{
                    item.finished = val
                    this.handleTasks()
                    /*
                    if (val) {
                      this.finishTask++
                    } else {
                      this.finishTask--
                    }
                    */
                  })
              }
              .card1()
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .swipeAction({end: this.deleteBtn(idx)})
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

  /* 组件内自定义构建函数，UI元素复用机制 @Builder
   * @Builder 所装饰的函数遵循 build() 函数语法规则，
   * 开发者可以将重复使用的UI元素抽象成⼀个方法，在build方法里调用。
   * */
  @Builder deleteBtn(idx: number) {
    Button('删')
      .fontSize(18)
      .width(70)
      .height(40)
      .type(ButtonType.Circle)
      .backgroundColor(Color.Red)
      .onClick((event: ClickEvent) => {
        // splice(start: number, deleteCount?: number): T[];
        this.tasks.splice(idx,1)
        this.handleTasks()
      })
  }
}
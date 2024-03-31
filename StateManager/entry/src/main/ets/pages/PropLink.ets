import {Task} from "../common/Common"


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


@Entry
@Component
struct PropLinkTask {

  @State totalTask: number = 0
  @State finishTask: number = 0
  // @State tasks: Task[] = []

  // handleTasks() {
  //
  //   this.totalTask = this.tasks.length
  //   this.finishTask = this.tasks.filter(item => item.finished).length
  //
  // }

  build() {
    Column({space: 10}) {
      // 1.任务进度卡片
      TaskHeader({finishTask: this.finishTask, totalTask: this.totalTask})

      // 2.任务列表
      // A '@Link' decorated attribute must be initialized with '$'. <etsLint>
      TaskList({finishTask: $finishTask, totalTask: $totalTask})

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}

@Component
struct TaskHeader {

  /* 父组件 @State  子组件 @Prop
   * prop 修饰属性 不可以初始化给默认值
   * 单向同步
   * 当父组件属性更新，会触发子组件视图刷新
   * 实际上是父组件的数据拷贝的一份传递给子组件，每次父组件数据改变都会拷贝一份新的数据给子组件
   * 所以子组件不论如何修改属性都对父组件无影响
   * */
  /*
   * Variables decorated by '@Prop', '@Link', '@Consume',
   * and '@ObjectLink' cannot be initialized locally. <etsLint>
   * */
  @Prop finishTask: number
  @Prop totalTask: number

  build() {
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
    .card()
    .margin({top: 20,bottom: 10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct TaskList {

  /* 父组件 @State  子组件 @Link
  * Link 修饰属性 不可以初始化给默认值
  * 双向同步
  * 当父组件属性更新，会触发子组件视图刷新，反之，亦然
  * 实际上是父组件的数据传递引用给给子组件，所以不论谁如何修改属性，相互都刷新
  * */
  @Link finishTask: number
  @Link totalTask: number
  @State tasks: Task[] = []

  handleTasks() {

    this.totalTask = this.tasks.length
    this.finishTask = this.tasks.filter(item => item.finished).length

  }

  build() {
    Column() {
      Button('新增任务').onClick((event: ClickEvent) => {
        this.tasks.push(new Task())
        this.handleTasks()
      })
        .width(200)
        .margin({bottom: 20})
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
              .card()
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

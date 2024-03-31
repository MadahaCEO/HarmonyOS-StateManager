@Entry
@Component
struct PCPage {

  @State total: number = 0
  @Provide lists: string[] = []

  build() {
    Column() {
      Text('总数: ' + this.lists.length)
      Button("自增").onClick((event: ClickEvent) => {
        this.lists.push('1')
        this.total = this.lists.length
      })

      // 隐式传参，这里并没有直接将 total和lists进行传递
      ItemList()
    }
  }
}


@Component
struct ItemList {

  /* 父组件@Provide  子组件@Consume  同样实现类似link双向传递
   * 扩组件 隐式的同步状态变量
   *
   * **/

  //Variables decorated by '@Prop', '@Link', '@Consume',
  // and '@ObjectLink' cannot be initialized locally. <etsLint>
  @Consume lists: string[]

  build() {
    List() {
      ForEach(
        this.lists,
        (item, idx) => {
          // The component 'ListItem' can only have a single child component.
          ListItem() {
            Row() {
              Text('idx '+ idx + '  item ' + item)
              Button("删除").onClick((event: ClickEvent) => {
                this.lists.splice(idx, 1)
              })
            }
          }
        }
      )
    }
  }
}
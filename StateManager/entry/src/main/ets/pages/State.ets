import router from '@ohos.router'


class Person {
  name: string
  age: number
  gf: Person
  constructor(name: string, age: number, gf?: Person) { // 问号表示参数可选
    this.name = name
    this.age = age
    this.gf = gf
  }
}


@Entry
@Component
struct StatePage {

  /* State 修饰的变量必须初始化
 * 可以修饰 number、string、boolean、object、class、enum以及这些类型的数组
 * 嵌套类型以及数组中的对象属性变化无法触发视图更新
 * */
  @State message: string = 'Hello World'
  @State fontSize: number = 50

  @State person: Person = new Person('jack', 29, new Person('Rose', 27))

  build() {
    Row() {
      Column({space: 20}) {
        Text(this.message)
          .fontSize(this.fontSize)
          .fontWeight(FontWeight.Bold)
        Button('Touch').onClick((event: ClickEvent) => {
          this.message = 'Hello HarmonyOS'
          this.fontSize = 30
        })
        Text(`${this.person.name} : ${this.person.age}`)
          .fontSize(30)
        Button('年龄增加').onClick((event: ClickEvent) => {
          this.person.age++
        })
        Text(`${this.person.gf.name}: ${this.person.gf.age}`)
          .fontSize(30)
        // 嵌套对象的属性改变不会触发视图刷新
        Button('女朋友年龄增加(无效)').onClick((event: ClickEvent) => {
          this.person.gf.age++
        })
        Button('Back').onClick((event: ClickEvent) => {
          router.back()
        })
          .margin({top: 30})
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
  }
}
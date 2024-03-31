
export class Task {
  // 静态变量，当前类的所有对象共享，无论创建多少个Task对象
  static id: number = 1
  // 任务名称
  name: string = `任务 ${Task.id++}`
  // 任务是否完成
  finished: boolean = false
}


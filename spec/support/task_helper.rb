def create_task(user,keyword:'',status: 0,priority: 0,expired_term: 1)
  count = user.tasks.count
  @task = user.tasks.create(
    name: "task name no.#{ count+1 }_#{keyword}",
    content: "task content no.#{ count+1 }",
    status:status,
    priority:priority,
    expired_at: DateTime.now + expired_term
  )
  @task
end
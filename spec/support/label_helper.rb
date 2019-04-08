def create_label(user)
  count = user.labels.count
  @label = user.labels.create(
    name: "task name",
    content: "task content"
  )
  @label
end

def build_label(user)
  count = user.labels.count
  @label = user.labels.build(
    name: "task name",
    content: "task content"
  )
  @label
end

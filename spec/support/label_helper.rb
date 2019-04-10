def create_label(user,keyword: "")
  count = user.labels.count
  @label = user.labels.create(
    name: "label name" + "#{keyword}",
    content: "label content" + "#{keyword}"
  )
  @label
end

def build_label(user)
  count = user.labels.count
  @label = user.labels.build(
    name: "label name",
    content: "label content"
  )
  @label
end

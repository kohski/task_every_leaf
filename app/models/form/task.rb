class Form::Task < Task
  REGISTRABLE_ATTRIBUTES = %i(
    name
    arrival_date(1i) arrival_date(2i) arrival_date(3i)
    published_at(1i) published_at(2i) published_at(3i) published_at(4i) published_at(5i)
  )
end
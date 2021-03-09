# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventsApp.Repo.insert!(%EventsApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EventsApp.Repo
alias EventsApp.Users.User
alias EventsApp.Events.Events

olivia = Repo.insert!(%User{name: "olivia", email: "blierolivia@gmail.com"})
ryan = Repo.insert!(%User{name: "ryan", email: "hart.ry@northeastern.edu"})

Repo.insert!(%Event{user_id: olivia.id, event_name: "Olivia's Birthday Party", description: "Happy birthday me!", date: "2021-07-15", time: "12:00:00"})
Repo.insert!(%Event{user_id: ryan.id, event_name: "Dumb event", description: "This is stupid like me!", date: "2021-03-10", time: "9:00:00"})
alias Whatever.Repo
alias Whatever.Types.Type

%Type{
  name: "web-search"
}
|> Repo.insert!()

%Type{
  name: "songs"
}
|> Repo.insert!()

%Type{
  name: "food"
}
|> Repo.insert!()

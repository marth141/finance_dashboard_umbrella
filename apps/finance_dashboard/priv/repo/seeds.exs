# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FinanceDashboard.Repo.insert!(%FinanceDashboard.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FinanceDashboard.Accounts

%{
  email: "ncasados@live.com",
  password: "test_password1",
  confirmed_at: NaiveDateTime.local_now(),
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.register_user()

%{
  amount: 100.37,
  name: "First Wallet",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_wallet()

%{
  amount: 1196.45,
  initial_pay_date: ~D[2021-06-02],
  name: "Day Job",
  frequency: "Bi-Weekly",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_income()

%{
  amount: (949.00 / 3) |> Float.round(2),
  initial_due_date: ~D[2021-06-01],
  name: "Rent 1/3",
  paid: false,
  frequency: "Monthly",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_bill()

%{
  amount: (949.00 / 3) |> Float.round(2),
  initial_due_date: ~D[2021-06-01],
  name: "Rent 2/3",
  paid: false,
  frequency: "Monthly",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_bill()

%{
  amount: 177.31,
  initial_due_date: ~D[2021-06-11],
  name: "UCCU Car",
  paid: false,
  frequency: "Monthly",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_bill()

%{
  amount: 45.00,
  initial_due_date: ~D[2021-06-01],
  name: "Internet",
  paid: false,
  frequency: "Monthly",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_bill()

%{
  amount: 100.00,
  initial_due_date: ~D[2021-06-05],
  name: "Credit Card",
  paid: false,
  frequency: "Monthly",
  user_id: 1,
  inserted_at: NaiveDateTime.local_now(),
  updated_at: NaiveDateTime.local_now()
}
|> Accounts.create_bill()

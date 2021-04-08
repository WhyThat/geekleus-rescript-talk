module Email = {
  type t = string
}

type t = {
  name: string,
  age: int,
  email: Email.t,
}

let persist = (user: t) => {
  Js.Promise.make((~resolve, ~reject as _) => {
    Js.Global.setTimeout(() => resolve(. user), 2000)->ignore
  })
}

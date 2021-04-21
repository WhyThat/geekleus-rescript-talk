module Email = {
  type t = string
  let emailRe = %re("/^[^\s@]+@[^\s@]+$/")
  let isValid = str => Js.Re.test_(emailRe, str)
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

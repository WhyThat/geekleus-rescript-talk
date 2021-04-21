module Email: {
  type t
  let make: string => option<t>
} = {
  type t = string
  let emailRe = %re("/^[^\s@]+@[^\s@]+$/")
  let isValid = str => Js.Re.test_(emailRe, str)
  let make = str => isValid(str) ? Some(str) : None
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

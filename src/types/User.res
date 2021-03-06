module Email: {
  type t
  let toString: t => string
  let make: string => option<t>
} = {
  type t = string
  let isValid: string => bool = str => Js.String.includes("@", str)
  let make: string => option<t> = str => isValid(str) ? Some(str) : None
  let toString: t => string = t => t
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

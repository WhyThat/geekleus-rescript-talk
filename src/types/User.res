module Email: {
  type t
  let make: string => option<t>
  let toString: t => string
} = {
  type t = string
  let emailRe = %re("/^[^\s@]+@[^\s@]+$/")
  let isValid = str => Js.Re.test_(emailRe, str)
  let make = str =>
    isValid(str)
      ? Some(str)
      : None
  let toString = t => t
}

type t = {
  name: string,
  age: int,
  email: Email.t,
}

type view = {
  name: string,
  age: int,
  email: string,
}

let make = (~name, ~age, ~email): option<t> =>
  switch Email.make(email) {
  | Some(email) =>
    Some({
      name: name,
      email: email,
      age: age,
    })
  | None => None
  }

let view: t => view = ({name, age, email}) => {
  name,
  age,
  email: email->Email.toString
}

let persist = (user: t) => {
  Js.Promise.make((~resolve, ~reject as _) => {
    Js.Global.setTimeout(() => resolve(. user), 2000)->ignore
  })
}

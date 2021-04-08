module Email_Error: {
  type t
  type error = MissingArobase(string)
  let make: string => result<t, error>
  let toString: t => string
} = {
  type t = string
  type error = MissingArobase(string)
  let isValid: t => bool = str => Js.String.includes("@", str)
  let make: string => result<t, error> = str => isValid(str) ? Ok(str) : Error(MissingArobase(str))
  let toString: t => string = t => t
}

module Email_Option: {
  type t
  let make: string => option<t>
  let toString: t => string
} = {
  type t = string
  let isValid: t => bool = str => Js.String.includes("@", str)
  let make: string => option<t> = str => isValid(str) ? Some(str) : None
  let toString: t => string = t => t
}


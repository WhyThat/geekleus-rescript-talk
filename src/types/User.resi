type t
type view = {
  name: string,
  age: int,
  email: string,
}
let make: (~name: string, ~age: int, ~email: string) => option<t>
let persist: t => Js.Promise.t<t>
let view: t => view

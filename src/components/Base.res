module Password: {
  type t
  type status =
    | Empty
    | Valid(string)
    | Invalid(string)
  let make: string => t
  let getStatus: t => status
} = {
  type t =
    | Empty
    | Valid(string)
    | Invalid(string)
  type status = Empty | Valid(string) | Invalid(string)
  let make: string => t = password =>
    switch password {
    | "" => Empty
    | password if Js.String.length(password) > 3 => Valid(password)
    | _ => Invalid(password)
    }

  let getStatus: t => status = t =>
    switch t {
    | Empty => Empty
    | Valid(password) => Valid(password)
    | Invalid(password) => Invalid(password)
    }
}

type state = Password.t

type actions = ChangePassword(string)

let reducer = (_state, action) => {
  switch action {
  | ChangePassword(password) => Password.make(password)
  }
}

let initialState: state = Password.make("")

let sendForm = state => {
  state
}

type json = {password: string}

exception UnvalidPassword
let send = (_password: string) => {
  Js.Promise.resolve("password saved")
}

@react.component
let make = () => {
  let (password, dispatch) = React.useReducer(reducer, initialState)

  let onPasswordChange = ev => {
    let passwordValue: string = ReactEvent.Form.target(ev)["value"]
    dispatch(ChangePassword(passwordValue))
  }

  let onClick = _ => {
    switch password->Password.getStatus {
    | Valid(pwd) => send(pwd)->ignore
    | _ => ()
    }
  }

  <div>
    <input
      type_="text"
      value={switch password->Password.getStatus {
      | Invalid(pwd)
      | Valid(pwd) => pwd
      | Empty => ""
      }}
      onChange=onPasswordChange
    />
    <div>
      {switch password->Password.getStatus {
      | Invalid(_) => React.string("Password not long enough")
      | Valid(_) => React.string("Password valid")
      | Empty => React.null
      }}
    </div>
    <button onClick> {React.string("SEND")} </button>
  </div>
}

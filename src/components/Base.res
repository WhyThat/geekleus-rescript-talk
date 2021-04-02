module Password = {
  type t = string
  let isValid = password => Js.String.length(password) > 3
}

type state = Password.t

type actions = ChangePassword(string)

let reducer = (_state, action) => {
  switch action {
  | ChangePassword(password) => password
  }
}

let initialState = ""

let sendForm = state => {
  state
}

type json = {password: string}

exception UnvalidPassword
let send = (password: string) => {
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
    if password->Password.isValid {
      send(password)->ignore
    } else {
      ()
    }
  }

  <div>
    <input type_="text" value={password} onChange=onPasswordChange />
    <div>
      {password->Password.isValid
        ? React.string("Password valid")
        : React.string("Password not long enough")}
    </div>
    <button onClick> {React.string("SEND")} </button>
  </div>
}

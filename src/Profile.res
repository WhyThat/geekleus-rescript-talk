module Style = {
  let input = "px-2 py-2 border-2 rounded-md border-gray-200 focus:outline-none focus:ring-1 focus:ring-pink-300 focus:border-transparent"
  let container = "flex flex-col shadow-xl"
  let header = "py-6 px-14 bg-gradient-to-tr from-gray-500 to-yellow-600 rounded-tl-2xl rounded-tr-2xl text-center space-y-8"
  let headerText = "text-white text-center font-bold text-xl"

  let form = "flex flex-col py-6 px-8 space-y-5 bg-white"
  let button = "w-full py-3 bg-yellow-500 text-black rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent shadow-lg"
}

type field =
  | Name
  | Email
  | Age

type status =
  | Iddle
  | Edited
  | Saved
  | Saving

type state = {
  name: string,
  email: string,
  age: int,
  status: status,
}

type action = Update(field, string) | SetStatus(status)

let reducer = (state, action: action) =>
  switch action {
  | Update(Name, name) => {...state, name: name, status: Edited}
  | Update(Email, emailStr) => {...state, email: emailStr, status: Edited}
  | Update(Age, age) => {
      ...state,
      age: age->Belt.Int.fromString->Belt.Option.getWithDefault(0),
      status: Edited,
    }
  | SetStatus(status) => {...state, status: status}
  }

let updateField = (dispatch, field, ev) => {
  let value: string = ReactEvent.Form.target(ev)["value"]
  dispatch(Update(field, value))
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(
    reducer,
    {
      name: "",
      email: "",
      age: 0,
      status: Iddle,
    },
  )

  let onChange = updateField(dispatch)

  let onClick = _ => {
    switch (state.status, User.Email.isValid(state.email)) {
    | (Edited, true) =>
      dispatch(SetStatus(Saving))
      User.persist(({email: state.email, name: state.name, age: state.age}: User.t))
      |> Js.Promise.then_(_ => {
        dispatch(SetStatus(Saved))
        Js.Promise.resolve()
      })
      |> ignore
    | _ => ()
    }
  }

  <div className=Style.container>
    <div className=Style.header>
      <h2 className=Style.headerText> {React.string("Profile form")} </h2>
    </div>
    <div className=Style.form>
      <input
        onChange={onChange(Name)}
        value=state.name
        type_="text"
        placeholder="Enter your name"
        className=Style.input
      />
      <input
        className=Style.input
        type_="email"
        onChange={onChange(Email)}
        placeholder="Enter your email"
        value=state.email
      />
      <input
        className=Style.input
        type_="number"
        onChange={onChange(Age)}
        value={state.age->Belt.Int.toString}
      />
      <button
        onClick
        disabled={switch state.status {
        | Edited => false
        | _ => true
        }}
        className=Style.button>
        {switch state.status {
        | Saving => React.string("Saving...")
        | Iddle
        | Saved =>
          React.string("Saved")
        | Edited => React.string("Save")
        }}
      </button>
    </div>
  </div>
}
let default = make

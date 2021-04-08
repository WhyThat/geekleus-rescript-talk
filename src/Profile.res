type status =
  | Iddle
  | Edited
  | Saving
  | Saved

module Style = {
  let input = "px-2 py-2 border-2 rounded-md border-gray-200 focus:outline-none focus:ring-1 focus:ring-pink-300 focus:border-transparent"
  let container = "flex flex-col shadow-xl"
  let header = "py-6 px-14 bg-gradient-to-tr from-gray-500 to-yellow-600 rounded-tl-2xl rounded-tr-2xl text-center space-y-8"
  let headerText = "text-white text-center font-bold text-xl"

  let form = "flex flex-col py-6 px-8 space-y-5 bg-white"
  let button = (email, status) => {
    let bg = switch (email->User.Email.isValid, status) {
    | (true, Edited) => "bg-yellow-500"
    | (false, Edited)
    | (_, Iddle)
    | (_, Saving)
    | (_, Saved) => "bg-gray-400"
    }
    "w-full py-3 text-black rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent shadow-lg " ++
    bg
  }
}

type field =
  | Name
  | Email
  | Age

type email =
  | Valid(User.Email.t)
  | Invalid(string)

type state = {
  name: string,
  email: email,
  age: int,
  status: status,
}

type action =
  | Update(field, string)
  | UpdateStatus(status)

let reducer = (state, action: action) =>
  switch action {
  | Update(Name, name) => {
      ...state,
      status: Edited,
      name: name,
    }
  | Update(Email, emailStr) => {
      ...state,
      status: Edited,
      email: emailStr,
    }
  | Update(Age, age) => {
      ...state,
      status: Edited,
      age: age->Belt.Int.fromString->Belt.Option.getWithDefault(0),
    }
  | UpdateStatus(status) => {...state, status: status}
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
    dispatch(UpdateStatus(Saving))
    switch state.email->User.Email.make {
    | Some(email) =>
      User.persist(({email: email, name: state.name, age: state.age}: User.t))
      |> Js.Promise.then_(_user => dispatch(UpdateStatus(Saved)) |> Js.Promise.resolve)
      |> ignore
    | None => ()
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
        disabled={switch (state.email->User.Email.isValid, state.status) {
        | (true, Edited) => false
        | _ => true
        }}
        className={Style.button(state.email, state.status)}>
        {switch state.status {
        | Saved => React.string("Saved")
        | Saving => React.string("Saving...")
        | Edited
        | Iddle =>
          React.string("Save")
        }}
      </button>
    </div>
  </div>
}

let default = make

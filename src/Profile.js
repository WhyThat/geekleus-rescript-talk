// Generated by ReScript, PLEASE EDIT WITH CARE

import * as User from "./types/User.js";
import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as Belt_Int from "bs-platform/lib/es6/belt_Int.js";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";
import * as Caml_option from "bs-platform/lib/es6/caml_option.js";

var input = "px-2 py-2 border-2 rounded-md border-gray-200 focus:outline-none focus:ring-1 focus:ring-pink-300 focus:border-transparent";

var container = "flex flex-col shadow-xl";

var header = "py-6 px-14 bg-gradient-to-tr from-gray-500 to-yellow-600 rounded-tl-2xl rounded-tr-2xl text-center space-y-8";

var headerText = "text-white text-center font-bold text-xl";

var form = "flex flex-col py-6 px-8 space-y-5 bg-white";

function button(email, status) {
  var bg;
  bg = email.TAG === /* Valid */0 && status === 1 ? "bg-yellow-500" : "bg-gray-400";
  return "w-full py-3 text-black rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent shadow-lg " + bg;
}

var Style = {
  input: input,
  container: container,
  header: header,
  headerText: headerText,
  form: form,
  button: button
};

function reducer(state, action) {
  if (action.TAG !== /* Update */0) {
    return {
            name: state.name,
            email: state.email,
            age: state.age,
            status: action._0
          };
  }
  switch (action._0) {
    case /* Name */0 :
        return {
                name: action._1,
                email: state.email,
                age: state.age,
                status: /* Edited */1
              };
    case /* Email */1 :
        var emailStr = action._1;
        var email = User.Email.make(emailStr);
        return {
                name: state.name,
                email: email !== undefined ? ({
                      TAG: 0,
                      _0: Caml_option.valFromOption(email),
                      [Symbol.for("name")]: "Valid"
                    }) : ({
                      TAG: 1,
                      _0: emailStr,
                      [Symbol.for("name")]: "Invalid"
                    }),
                age: state.age,
                status: /* Edited */1
              };
    case /* Age */2 :
        return {
                name: state.name,
                email: state.email,
                age: Belt_Option.getWithDefault(Belt_Int.fromString(action._1), 0),
                status: /* Edited */1
              };
    
  }
}

function updateField(dispatch, field, ev) {
  var value = ev.target.value;
  return Curry._1(dispatch, {
              TAG: 0,
              _0: field,
              _1: value,
              [Symbol.for("name")]: "Update"
            });
}

function Profile(Props) {
  var match = React.useReducer(reducer, {
        name: "",
        email: {
          TAG: 1,
          _0: "",
          [Symbol.for("name")]: "Invalid"
        },
        age: 0,
        status: /* Iddle */0
      });
  var dispatch = match[1];
  var state = match[0];
  var onChange = function (param, param$1) {
    return updateField(dispatch, param, param$1);
  };
  var onClick = function (param) {
    Curry._1(dispatch, {
          TAG: 1,
          _0: /* Saving */2,
          [Symbol.for("name")]: "UpdateStatus"
        });
    var email = state.email;
    if (email.TAG !== /* Valid */0) {
      return ;
    }
    User.persist({
            name: state.name,
            age: state.age,
            email: email._0
          }).then(function (_user) {
          return Promise.resolve(Curry._1(dispatch, {
                          TAG: 1,
                          _0: /* Saved */3,
                          [Symbol.for("name")]: "UpdateStatus"
                        }));
        });
    
  };
  var email = state.email;
  var tmp;
  tmp = email.TAG === /* Valid */0 ? User.Email.toString(email._0) : email._0;
  var match$1 = state.email;
  var match$2 = state.status;
  var tmp$1;
  tmp$1 = match$1.TAG === /* Valid */0 ? match$2 !== 1 : true;
  var match$3 = state.status;
  return React.createElement("div", {
              className: container
            }, React.createElement("div", {
                  className: header
                }, React.createElement("h2", {
                      className: headerText
                    }, "Profile form")), React.createElement("div", {
                  className: form
                }, React.createElement("input", {
                      className: input,
                      placeholder: "Enter your name",
                      type: "text",
                      value: state.name,
                      onChange: (function (param) {
                          return onChange(/* Name */0, param);
                        })
                    }), React.createElement("input", {
                      className: input,
                      placeholder: "Enter your email",
                      type: "email",
                      value: tmp,
                      onChange: (function (param) {
                          return onChange(/* Email */1, param);
                        })
                    }), React.createElement("input", {
                      className: input,
                      type: "number",
                      value: String(state.age),
                      onChange: (function (param) {
                          return onChange(/* Age */2, param);
                        })
                    }), React.createElement("button", {
                      className: button(state.email, state.status),
                      disabled: tmp$1,
                      onClick: onClick
                    }, match$3 !== 2 ? (
                        match$3 >= 3 ? "Saved" : "Save"
                      ) : "Saving...")));
}

var make = Profile;

var $$default = Profile;

export {
  Style ,
  reducer ,
  updateField ,
  make ,
  $$default ,
  $$default as default,
  
}
/* react Not a pure module */

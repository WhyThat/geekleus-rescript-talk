// Generated by ReScript, PLEASE EDIT WITH CARE


function make(str) {
  if (str.includes("@")) {
    return {
            TAG: 0,
            _0: str,
            [Symbol.for("name")]: "Ok"
          };
  } else {
    return {
            TAG: 1,
            _0: {
              _0: str,
              [Symbol.for("name")]: "MissingArobase"
            },
            [Symbol.for("name")]: "Error"
          };
  }
}

function toString(t) {
  return t;
}

var Email_Error = {
  make: make,
  toString: toString
};

function make$1(str) {
  if (str.includes("@")) {
    return str;
  }
  
}

function toString$1(t) {
  return t;
}

var Email_Option = {
  make: make$1,
  toString: toString$1
};

export {
  Email_Error ,
  Email_Option ,
  
}
/* No side effect */
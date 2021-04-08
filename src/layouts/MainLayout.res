@react.component
let make = (~children) => {
  let minWidth = ReactDOM.Style.make(~minWidth="20rem", ())
  <div style=minWidth className="flex lg:justify-center">
    <div className="max-w-5xl w-full lg:w-3/4 text-gray-900 font-base">
      <main className="mt-4 mx-4"> children </main>
    </div>
  </div>
}

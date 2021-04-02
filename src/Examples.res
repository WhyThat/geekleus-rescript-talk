type props = unit

let default = (_props: props) =>
  <div>
    <Base />
  </div>

let getServerSideProps = _ctx => {
  let props = ()
  Js.Promise.resolve({"props": props})
}

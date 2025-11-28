import "./style.css";
import kaplay from "kaplay";

const k = kaplay({
  width: 200,
  height: 200,
  background: "#d46eb3",
});
const player = k.add([k.rect(40, 60), k.pos(10, 10)]);

import kaplay from "kaplay";
import "./game.css";
import Charakter from "../char/Charakter";
import { loadAssets } from "../../assets";

const k = kaplay({
  width: 320,
  height: 240,
  font: "sans-serif",
  scale: 2,
  background: [0, 0, 255],
});

loadAssets(k);

new Charakter(k, 0);
new Charakter(k, 1);
new Charakter(k, 2);
new Charakter(k, 3);
new Charakter(k, 4);
new Charakter(k, 5);

import "./style.css";
import kaplay from "kaplay";
import Charakter from "./entities/charakter/Charakter";
import { loadAssets } from "./assets";
import { gameState } from "./state/gameState";

const k = kaplay({
  width: 320,
  height: 240,
  font: "sans-serif",
  scale: 2,
  background: "#757575",
});

loadAssets(k);

gameState.party.forEach((char, index) => new Charakter(k, index, char));
gameState.enemies.forEach((char, index) => new Charakter(k, index + 3, char));

import "./style.css";
import kaplay from "kaplay";
import { loadAssets } from "./assets";
import { registerBattleScene } from "./scenes/battle/battle";

const k = kaplay({
  width: 320,
  height: 240,
  font: "sans-serif",
  scale: 2,
  background: "#757575",
});
// k.debug.inspect = true;

const gameContainer = document.querySelector("#game");
if (!gameContainer) {
  throw new Error("#game container not found");
} else {
  gameContainer.appendChild(k.canvas);
}

loadAssets(k);
registerBattleScene(k);

k.go("battle");

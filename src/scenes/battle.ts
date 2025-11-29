import type { KAPLAYCtx } from "kaplay";
import { gameState } from "../state/gameState";
import Charakter from "./Charakter";
import BattleUI from "../ui/battle/BattleUi";
import { shuffleArray } from "../utils";

export function registerBattleScene(k: KAPLAYCtx) {
  k.scene("battle", () => {
    updateTurnOrder();
    gameState.charackters.forEach((char, index) => {
      if (!char) return;
      new Charakter(k, index, char);
    });
    new BattleUI();
  });
}

function updateTurnOrder() {
  const turnOrder: number[] = [];
  gameState.charackters.forEach((char, index) => {
    if (char) turnOrder.push(index);
  });
  shuffleArray(turnOrder);
  gameState.turnOrder = turnOrder;
  gameState.currentTurnIndex = 0;
  gameState.currentChar = gameState.turnOrder[gameState.currentTurnIndex];
}

export function nextChar() {
  gameState.currentTurnIndex += 1;
  if (gameState.currentTurnIndex >= gameState.turnOrder.length) {
    updateTurnOrder();
  } else {
    gameState.currentChar = gameState.turnOrder[gameState.currentTurnIndex];
  }
  document.dispatchEvent(new CustomEvent("nextChar"));
}

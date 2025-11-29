import type { GameState } from "../types";
import { HERO, MAGE, ENEMY } from "../data/characters";

export const gameState: GameState = {
  currentScene: "menu",
  charackters: [MAGE, MAGE, HERO, ENEMY, null, ENEMY],
  turnOrder: [],
  currentTurnIndex: 0,
  currentChar: 0,
};

import type { GameState } from "../types";
import { HERO, MAGE, ENEMY } from "../data/characters";

export const gameState: GameState = {
  currentScene: "menu",
  currentCharakter: 2,
  charackters: [HERO, MAGE, MAGE, ENEMY, ENEMY, ENEMY],
};

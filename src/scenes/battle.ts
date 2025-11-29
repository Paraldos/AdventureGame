import type { KAPLAYCtx } from "kaplay";
import { gameState } from "../state/gameState";
import Charakter from "./Charakter";
import BattleUI from "../ui/battle/BattleUi";

export function registerBattleScene(k: KAPLAYCtx) {
  k.scene("battle", () => {
    gameState.charackters.forEach((char, index) => {
      new Charakter(k, index, char);
    });
    new BattleUI();
  });
}

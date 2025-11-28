import type { KAPLAYCtx } from "kaplay";
import Charakter from "../entities/charakter/Charakter";
import { gameState } from "../state/gameState";

export function registerBattleScene(k: KAPLAYCtx) {
  k.scene("battle", () => {
    gameState.charackters.forEach((char, index) => {
      new Charakter(k, index, char);
    });
    addBattleUI(k);
  });
}

function addBattleUI(k: KAPLAYCtx) {
  const boxHeight = 60;
  const boxY = k.height() - boxHeight;
  const activeIndex = gameState.currentCharakter;
  const activeChar = gameState.charackters[activeIndex];

  const uiBox = k.add([
    k.rect(k.width(), boxHeight),
    k.pos(0, boxY),
    k.color(0, 0, 0),
    k.opacity(0.8),
    k.z(90),
  ]);

  const currentCharakterLabel = k.add([
    k.text(activeChar ? `${activeChar.name}` : "", {
      font: "MonoPixelFont",
      size: 8,
    }),
    k.pos(8, boxY),
    k.z(100),
  ]);

  const nextButton = k.add([
    k.rect(60, 20),
    k.pos(8 + 60, boxY + boxHeight / 2),
    k.anchor("center"),
  ]);
}

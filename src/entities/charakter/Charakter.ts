import type {
  KAPLAYCtx,
  GameObj,
  PosComp,
  SpriteComp,
  AnchorComp,
} from "kaplay";
import type { CharakterData } from "../../state/types";
import { gameState } from "../../state/gameState";

export default class Charakter {
  private readonly xPositions = [32, 64, 96];

  rank: number;
  k: KAPLAYCtx;
  charakterData: CharakterData;

  posX: number;
  posY: number;

  mainSprite: GameObj<PosComp | SpriteComp | AnchorComp>;
  pointerSprite?: GameObj<PosComp | SpriteComp | AnchorComp>;

  constructor(k: KAPLAYCtx, rank: number, charakterData: CharakterData) {
    this.rank = rank;
    this.k = k;
    this.charakterData = charakterData;

    this.posX = this.calculatePosX(rank);
    this.posY = this.k.height() / 2;
    this.mainSprite = this.drawMainSprite();

    if (gameState.currentCharakter === rank) {
      this.drawPointer();
    }
  }

  private calculatePosX(rank: number): number {
    const isPlayerSide = rank < 3;
    const index = isPlayerSide ? rank : rank - 3;
    const baseX = this.xPositions[index];
    return isPlayerSide ? baseX : this.k.width() - baseX;
  }

  private drawMainSprite(): GameObj<PosComp | SpriteComp | AnchorComp> {
    return this.k.add([
      this.k.sprite("player"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
    ]);
  }

  private drawPointer() {
    const baseY = this.posY - 16;
    const amplitude = 3;
    const speed = 4;

    this.pointerSprite = this.k.add([
      this.k.sprite("pointer"),
      this.k.pos(this.posX, baseY),
      this.k.anchor("center"),
    ]);

    this.k.onUpdate(() => {
      if (!this.pointerSprite) return;
      const t = this.k.time() * speed;
      this.pointerSprite.pos.y = baseY + Math.sin(t) * amplitude;
    });

    return this.pointerSprite;
  }
}

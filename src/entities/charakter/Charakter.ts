import { type KAPLAYCtx } from "kaplay";
import { type CharakterData } from "../../state/gameState";

export default class Charakter {
  private readonly xPositions = [32, 64, 96];
  rank: number;
  k: KAPLAYCtx;
  charakterData: CharakterData;

  posX: number;
  posY: number;
  mainSprite: ReturnType<KAPLAYCtx["add"]>;
  pointer: ReturnType<KAPLAYCtx["add"]>;

  constructor(k: KAPLAYCtx, rank: number, charakterData: CharakterData) {
    this.rank = rank;
    this.k = k;
    this.charakterData = charakterData;

    this.posX = this.calculatePosX(rank);
    this.posY = this.k.height() / 2;
    this.mainSprite = this.drawMainSprite();
    this.pointer = this.drawPointer();
  }

  private calculatePosX(rank: number): number {
    const isPlayerSide = rank < 3;
    const index = isPlayerSide ? rank : rank - 3;
    const baseX = this.xPositions[index];
    return isPlayerSide ? baseX : this.k.width() - baseX;
  }

  drawMainSprite() {
    return this.k.add([
      this.k.sprite("player"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
    ]);
  }

  drawPointer() {
    return this.k.add([
      this.k.sprite("pointer"),
      this.k.pos(this.posX, this.posY - 16),
      this.k.anchor("center"),
    ]);
  }
}

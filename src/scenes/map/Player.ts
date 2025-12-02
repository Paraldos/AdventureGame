import type { KAPLAYCtx, GameObj } from "kaplay";

export default class Player {
  k: KAPLAYCtx;
  mainSprite?: GameObj;
  posX: number = 15;
  posY: number = 15;

  constructor(k: KAPLAYCtx) {
    this.k = k;
    console.log("player");
    this.drawMainSprite();
  }

  drawMainSprite(): void {
    this.mainSprite = this.k.add([
      this.k.sprite("player"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
    ]);
  }
}

import type {
  KAPLAYCtx,
  GameObj,
  PosComp,
  SpriteComp,
  AnchorComp,
} from "kaplay";
import type { CharakterData } from "../types";
import { gameState } from "../state/gameState";

export default class Charakter {
  private k: KAPLAYCtx;
  private rank: number;
  private charakterData: CharakterData;

  private readonly xPositions = [32, 64, 96, 224, 256, 288];
  private posX: number;
  private posY: number;
  private mainSprite: GameObj<PosComp | SpriteComp | AnchorComp>;
  private pointer?: GameObj<PosComp | SpriteComp | AnchorComp>;

  constructor(k: KAPLAYCtx, rank: number, charakterData: CharakterData) {
    this.k = k;
    this.rank = rank;
    this.charakterData = charakterData;

    this.posX = this.xPositions[rank];
    this.posY = this.k.height() / 2;
    this.mainSprite = this.drawMainSprite();

    this.updatePointer();
    document.addEventListener("nextChar", () => this.updatePointer());
  }

  private drawMainSprite(): GameObj<PosComp | SpriteComp | AnchorComp> {
    return this.k.add([
      this.k.sprite("player"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
    ]);
  }

  private updatePointer(): void {
    gameState.currentChar !== this.rank
      ? this.pointer?.destroy()
      : this.drawPointer();
  }

  private drawPointer(): void {
    this.pointer?.destroy();

    const baseY = this.posY - 16;
    const amplitude = 3;
    const speed = 4;

    this.pointer = this.k.add([
      this.k.sprite("pointer"),
      this.k.pos(this.posX, baseY),
      this.k.anchor("center"),
    ]);

    this.k.onUpdate(() => {
      if (!this.pointer) return;
      const t = this.k.time() * speed;
      this.pointer.pos.y = baseY + Math.sin(t) * amplitude;
    });
  }
}

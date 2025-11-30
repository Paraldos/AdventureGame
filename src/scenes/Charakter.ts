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
  private mainSprite?: GameObj;
  private pointer?: GameObj;
  private selector?: GameObj;

  constructor(k: KAPLAYCtx, rank: number, charakterData: CharakterData) {
    this.k = k;
    this.rank = rank;
    this.charakterData = charakterData;

    this.posX = this.xPositions[rank];
    this.posY = this.k.height() / 2;
    this.drawMainSprite();

    this.drawPointer();
    document.addEventListener("nextChar", () => this.onNextChar());
    document.addEventListener("enableTargets", (e) =>
      this.onEnableTargets(e as CustomEvent)
    );
  }

  private onNextChar() {
    this.selector?.destroy();
    this.drawPointer();
  }

  private onEnableTargets(e: CustomEvent) {
    const targets = e.detail.targets;
    this.selector?.destroy();
    if (targets.includes(this.rank)) this.drawSelector();
  }

  private drawSelector(): void {
    this.selector = this.k.add([
      this.k.sprite("selector"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
    ]);
  }

  private drawMainSprite(): void {
    this.mainSprite = this.k.add([
      this.k.sprite("player"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
    ]);
  }

  private drawPointer(): void {
    this.pointer?.destroy();
    if (gameState.currentChar !== this.rank) return;

    const baseY = this.posY - 18;
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

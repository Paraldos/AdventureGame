import type { KAPLAYCtx, GameObj } from "kaplay";

export default class CharakterSelector {
  k: KAPLAYCtx;
  posX: number;
  posY: number;

  selector?: GameObj;

  constructor(k: KAPLAYCtx, posX: number, posY: number) {
    this.k = k;
    this.posX = posX;
    this.posY = posY;
    this.drawSelector();
  }

  destroy() {
    this.selector?.destroy();
  }

  drawSelector(): void {
    this.selector = this.k.add([
      this.k.sprite("selector"),
      this.k.pos(this.posX, this.posY),
      this.k.anchor("center"),
      this.k.area(),
    ]);

    this.selector?.onClick(() => this.onClick());
    this.selector?.onHover(() => this.onHover());
    this.selector?.onHoverEnd(() => this.onHoverEnd());
  }

  onClick() {
    console.log("click");
  }

  onHover() {
    console.log("Hover");
  }

  onHoverEnd() {
    console.log("Hover End");
  }
}

import type { KAPLAYCtx } from "kaplay";
import Player from "./Player";

export function registerMapScene(k: KAPLAYCtx) {
  k.scene("map", () => {
    new Player(k);
  });
}

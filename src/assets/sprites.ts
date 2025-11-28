import type { KAPLAYCtx } from "kaplay";

/**
 * Register / load all sprite assets for the game.
 * Call this once during startup.
 */
export function loadSprites(k: KAPLAYCtx) {
  k.loadSprite("player", "public/img/player.png");
  k.loadSprite("pointer", "public/img/pointer.png");
}

import type { KAPLAYCtx } from "kaplay";
import { loadSprites } from "./sprites";

/**
 * Central place to load all assets (sprites, sounds, etc.).
 * Call this once after creating `k`.
 */
export function loadAssets(k: KAPLAYCtx) {
  k.loadFont("MonoPixelFont", "public/MonoPixelFont.ttf");
  loadSprites(k);
}
